import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiki_sdk_flutter/main.dart';

import 'consent_detail.dart';

class ConsentCard extends StatelessWidget {
  final bool toggleStatus;
  final ConsentModel consent;
  final Function(bool, BuildContext) modifyConsent;

  const ConsentCard(this.consent, this.toggleStatus, this.modifyConsent, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      consent!.transactionId!)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Toggle Consent"),
                        Switch(
                          value: toggleStatus,
                          activeColor: Colors.green,
                          onChanged: (bool allow) => modifyConsent(allow, context),
                        )
                      ])
                ]),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ConsentDetail(consent)))));
  }
}
