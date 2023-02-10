import 'dart:async';
import 'dart:io';

import 'package:example/widgets/body_card.dart';
import 'package:example/widgets/consent_card.dart';
import 'package:example/widgets/destination_card.dart';
import 'package:example/widgets/ownership_card.dart';
import 'package:example/widgets/request_list.dart';
import 'package:example/widgets/wallet_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:tiki_sdk_flutter/main.dart';

import 'request.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<StatefulWidget> createState() => HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> {
  TikiSdk? tikiSdk;
  List<String> wallets = [];
  String bodyData = "{\"message\" : \"Hello Tiki!\"}";
  String httpMethod = "POST";
  String url = "https://postman-echo.com/post";
  int interval = 15;
  OwnershipModel? ownership;
  ConsentModel? consent;
  List<Request> requests = [];
  bool toggleState = false;
  Timer? timer;

  var log;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            color: const Color(0xFFDDDDDD),
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Try It Out", style: TextStyle(fontSize: 32)),
                Padding(padding: EdgeInsets.all(8)),
                Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      "Wallet",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Padding(padding: EdgeInsets.all(8)),
                WalletCard(),
                Padding(padding: EdgeInsets.all(8)),
                OwnershipCard(),
                Padding(padding: EdgeInsets.all(8)),
                ConsentCard(),
                Padding(padding: EdgeInsets.all(8)),
                Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      "Outbound Requests",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Padding(padding: EdgeInsets.all(8)),
                DestinationCard(),
                Padding(padding: EdgeInsets.all(8)),
                BodyCard(),
                Padding(padding: EdgeInsets.all(8)),
                RequestList()
              ],
            ))));
  }

  void startTimer() {
    if (timer == null || timer!.isActive == false) {
      TikiSdkDestination destination =
          TikiSdkDestination([url], uses: [httpMethod]);
      timer = Timer.periodic(Duration(seconds: interval), (timer) {
        _makeRequest(destination);
      });
    }
  }

  void stopTimer() {
    if (timer?.isActive == true) {
      timer!.cancel();
    }
  }

  Future<void> _makeRequest(TikiSdkDestination destination) async {
    tikiSdk!.applyConsent(ownership!.source, destination, () async {
      try {
        var urlReq = Uri.parse(url);
        http.Response response;
        if (httpMethod == "POST") {
          response = await http
              .post(urlReq, body: {'name': 'doodle', 'color': 'blue'});
        } else {
          response = await http.get(urlReq);
        }
        if (response.statusCode < 200 || response.statusCode > 299) {
          throw HttpException(response.body);
        }
        log.add(Request("🟢", response.body));
      } catch (error) {
        log.add(Request("🔴", error.toString()));
      }
    }, onBlocked: (reason) {
      log.add(Request("🔴", "Blocked: $reason"));
    });
    setState(() {});
  }

  Future<void> _getOrAssignOwnership(String source, TikiSdk tikiSdk) async {
    OwnershipModel? localOwnership = tikiSdk.getOwnership(source);
    if (localOwnership != null) {
      ownership = localOwnership;
      setState(() {});
      return;
    }
    await tikiSdk
        .assignOwnership(source, TikiSdkDataTypeEnum.stream, ["Test data"]);
    ownership = tikiSdk.getOwnership(source);
    setState(() {});
  }

  Future<void> _getOrModifyConsent(
      bool allow, TikiSdkDestination destination, TikiSdk tikiSdk) async {
    TikiSdkDestination destination =
        TikiSdkDestination([url], uses: [httpMethod]);
    tikiSdk.applyConsent(ownership!.source, destination, () async {
      ConsentModel localConsent = tikiSdk.getConsent(ownership!.source)!;
      if (!allow) {
        await tikiSdk.modifyConsent(
            Bytes.base64UrlEncode(ownership!.transactionId!),
            const TikiSdkDestination.none());
      }
      consent = localConsent;
      toggleState = allow;
      setState(() {});
    }, onBlocked: (String reason) async {
      ConsentModel? localConsent = tikiSdk.getConsent(ownership!.source);
      if (localConsent == null) {
        localConsent = await tikiSdk.modifyConsent(
            Bytes.base64UrlEncode(ownership!.transactionId!),
            allow ? destination : const TikiSdkDestination.none());
      } else if (allow) {
        localConsent = await tikiSdk.modifyConsent(
            Bytes.base64UrlEncode(ownership!.transactionId!), destination);
      }
      consent = localConsent;
      toggleState = allow;
      setState(() {});
    });
  }

  Future<void> loadTikiSdk([String? address]) async {
    TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder()
      ..origin(model.origin)
      ..apiId(model.apiId);
    if (address != null) builder.address(address);
    model.tikiSdk = await builder.build();
    if (address == null) {
      model.wallets.add(model.tikiSdk!.address);
    }
    await ownershipService.getOrAssignOwnership(
        destinationService.model.source, model.tikiSdk!);
    await consentService.getOrModifyConsent(
        false,
        ownershipService.model.ownership!.transactionId!,
        destinationService.model,
        model.tikiSdk!);
    requestsService.stopTimer();
    requestsService.startTimer(destinationService.model, model.tikiSdk!);
    notifyListeners();
  }
}
