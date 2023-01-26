import 'package:example_app/consent/layout_btn.dart';
import 'package:example_app/destination/layout_body_btn.dart';
import 'package:example_app/destination/layout_btn.dart';
import 'package:example_app/ownership/layout_btn.dart';
import 'package:example_app/requests/layout_list.dart';
import 'package:example_app/wallet/layout_btn.dart';
import 'package:flutter/cupertino.dart';

class TryItOutLayout extends StatelessWidget {
  const TryItOutLayout({super.key});

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
                WalletLayoutBtn(),
                Padding(padding: EdgeInsets.all(8)),
                OwnershipLayoutBtn(),
                Padding(padding: EdgeInsets.all(8)),
                ConsentLayoutBtn(),
                Padding(padding: EdgeInsets.all(8)),
                Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      "Outbound Requests",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                Padding(padding: EdgeInsets.all(8)),
                DestinationLayoutBtn(),
                Padding(padding: EdgeInsets.all(8)),
                DestinationLayoutBodyBtn(),
                Padding(padding: EdgeInsets.all(8)),
                RequestsLayoutList()
              ],
            ))));
  }
}
