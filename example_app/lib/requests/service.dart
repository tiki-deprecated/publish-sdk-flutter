import 'dart:async';
import 'dart:io';

import 'package:example_app/requests/req_model.dart';
import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/main.dart';
import 'package:http/http.dart' as http;

import '../destination/model.dart';
import 'controller.dart';
import 'model.dart';

class RequestsService extends ChangeNotifier {
  RequestsModel model = RequestsModel();
  RequestsController controller = RequestsController();
  Timer? timer;

  startTimer(DestinationModel destination, TikiSdk tikiSdk){
    if(timer == null || timer!.isActive == false) {
      timer = Timer.periodic(Duration(seconds: destination.interval),  (timer){
      _makeRequest(destination, tikiSdk);
    });
    }
  }

  stopTimer(){
    if(timer?.isActive == true) {
      timer!.cancel();
    }
  }

  Future<void> _makeRequest(DestinationModel destination, TikiSdk tikiSdk) async {
    try {
      var url = Uri.parse(destination.url);
      var response;
      if (destination.httpMethod == "POST") {
        response = await http.post(
            url, body: {'name': 'doodle', 'color': 'blue'});
      } else {
        response = await http.get(url);
      }
      if(response.statusCode < 200 || response.statusCode > 299){
        throw HttpException(response.body);
      }
      model.log.add(RequestModel("🟢", response.body));
    }catch(error){
      model.log.add(RequestModel("🔴", error.toString()));
    }
    notifyListeners();
  }
}
