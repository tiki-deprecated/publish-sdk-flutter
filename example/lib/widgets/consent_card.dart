import 'package:example/consent/consent_detail.dart';
import 'package:example/consent/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiki_sdk_flutter/main.dart';

class ConsentLayoutBtn extends StatelessWidget {
  const ConsentLayoutBtn({super.key});

  @override
  Widget build(BuildContext context) {
    ConsentService service = Provider.of<ConsentService>(context, listen: true);
    return service.model.consent == null
        ? Container()
        : Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1.0, color: const Color(0xFFCCCCCC)),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: GestureDetector(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Expanded(
                            child: Text(
                          "Consent",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        Icon(Icons.keyboard_arrow_right)
                      ]),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  Text(Bytes.base64UrlEncode(
                      service.model.consent!.transactionId!)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Toggle Consent"),
                        Switch(
                          value: service.model.isConsentGiven,
                          activeColor: Colors.green,
                          onChanged: (bool allow) =>
                              service.controller.modifyConsent(allow, context),
                        )
                      ])
                ]),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider.value(
                        value: service, child: const ConsentLayoutDetail())))));
  }
}
