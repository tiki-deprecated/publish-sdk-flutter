import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

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
  final String origin;
  final String publishingId;
  final TikiSdk initialTikiSdk;

  const HomeWidget(this.initialTikiSdk, this.publishingId, this.origin, {super.key});

  @override
  State<StatefulWidget> createState() => HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> {
  List<Request> log = [];
  List<String> wallets = [];

  String bodyData = "{\"message\" : \"Hello Tiki!\"}";
  String httpMethod = "POST";
  String url = "https://postman-echo.com/post";
  int interval = 15;
  bool toggleState = false;

  ConsentModel? consent;
  OwnershipModel? ownership;

  Timer? timer;

  late TikiSdk tikiSdk;

  @override
  void initState() {
    tikiSdk = widget.initialTikiSdk;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(ownership == null) _getOrAssignOwnership();
    return SafeArea(
        child: Container(
            color: const Color(0xFFDDDDDD),
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Try It Out", style: TextStyle(fontSize: 32)),
                const Padding(padding: EdgeInsets.all(8)),
                const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      "Wallet",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Padding(padding: EdgeInsets.all(8)),
                WalletCard(wallets, tikiSdk.address, _loadTikiSdk),
                const Padding(padding: EdgeInsets.all(8)),
                OwnershipCard(ownership),
                const Padding(padding: EdgeInsets.all(8)),
                ConsentCard(consent, toggleState, _getOrModifyConsent),
                const Padding(padding: EdgeInsets.all(8)),
                const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      "Outbound Requests",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Padding(padding: EdgeInsets.all(8)),
                DestinationCard(url, httpMethod, interval, _updateDestination),
                const Padding(padding: EdgeInsets.all(8)),
                BodyCard(bodyData, _updateBody),
                const Padding(padding: EdgeInsets.all(8)),
                RequestList(log)
              ],
            ))));
  }

  void _startTimer() {
    if (timer == null || timer!.isActive == false) {
      timer = Timer.periodic(Duration(seconds: interval), (timer) {
        _makeRequest();
      });
    }
  }

  void _stopTimer() {
    if (timer?.isActive == true) {
      timer!.cancel();
    }
  }

  void _updateDestination(String url, String httpMethod, int interval){
    setState(() {
      this.url = url;
      this.httpMethod = httpMethod;
      this.interval = interval;
    });
  }

  void _updateBody(String body){
    bodyData = body;
    _getOrAssignOwnership();
  }

  Future<void> _loadTikiSdk([String? address]) async {
    TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder()
      ..origin(widget.origin)
      ..publishingId(widget.publishingId);
    if (address != null) builder.address(address);
    tikiSdk = await builder.build();
    if (address == null) {
      wallets.add(tikiSdk.address);
    }
    await _getOrAssignOwnership();
    _stopTimer();
    _startTimer();
    setState(() {});
  }

  Future<void> _makeRequest() async {
    if(ownership == null){
      await _getOrAssignOwnership();
      return;
    }
    var urlReq = Uri.parse(url);
    TikiSdkDestination destination =
        TikiSdkDestination([urlReq.host], uses: [httpMethod]);
    tikiSdk.applyConsent(ownership!.source, destination, () async {
      try {
        http.Response response;
        if (httpMethod == "POST") {
          response = await http.post(urlReq, body: bodyData);
        } else {
          response = await http.get(urlReq);
        }
        if (response.statusCode < 200 || response.statusCode > 299) {
          throw HttpException(response.body);
        }
        setState(() {
          log.add(Request("🟢", response.body));
        });
      } catch (error) {
        setState(() {
          log.add(Request("🔴", error.toString()));
        });
      }
    }, onBlocked: (reason) {
      setState(() {
        log.add(Request("🔴", "Blocked: $reason"));
      });
    });
  }

  Future<void> _getOrAssignOwnership() async {
    String source =
        Bytes.base64UrlEncode(Uint8List.fromList(bodyData.codeUnits));
    OwnershipModel? localOwnership = tikiSdk.getOwnership(source);
    if (localOwnership != null) {
      setState(() {
        ownership = localOwnership;
      });
      return;
    }
    await tikiSdk
        .assignOwnership(source, TikiSdkDataTypeEnum.stream, ["Test data"]);
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
      ownership = tikiSdk.getOwnership(source)!;
    }));
  }

  Future<void> _getOrModifyConsent(bool allow) async {
    if(ownership == null){
      await _getOrAssignOwnership();
      return;
    }
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

}
