import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/main.dart';

import 'ownership_detail.dart';

class OwnershipCard extends StatelessWidget {
  final OwnershipModel? ownership;

  const OwnershipCard(this.ownership, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                      "Ownership NFT",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    )),
                    Icon(Icons.keyboard_arrow_right)
                  ]),
              const Padding(padding: EdgeInsets.all(8.0)),
              Text(
                ownership == null
                    ? ""
                    : Bytes.base64UrlEncode(ownership!.transactionId!),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.only(bottom: 8))
            ]),
            onTap: () => ownership == null
                ? null
                : Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OwnershipDetail(ownership!)))));
  }
}
