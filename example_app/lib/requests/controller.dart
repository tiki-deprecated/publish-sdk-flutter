import 'package:example_app/destination/service.dart';
import 'package:example_app/requests/service.dart';
import 'package:example_app/wallet/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tiki_sdk_flutter/main.dart';

import '../destination/model.dart';

class RequestsController{
  startTimer(BuildContext context){
    TikiSdk tikiSdk = Provider.of<WalletService>(context).model.tikiSdk!;
    DestinationModel destination = Provider.of<DestinationService>(context, listen: false).model;
    RequestsService requestsService = Provider.of<RequestsService>(context, listen: false);
    requestsService.startTimer(destination, tikiSdk);
  }

  stopTimer(BuildContext context){
    RequestsService requestsService = Provider.of<RequestsService>(context, listen: false);
    requestsService.stopTimer();
  }
}