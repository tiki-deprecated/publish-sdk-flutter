import 'package:example_app/ownership/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiki_sdk_flutter/main.dart';

import 'model.dart';

class OwnershipLayoutDetail extends StatelessWidget {
  OwnershipLayoutDetail({super.key});

  @override
  Widget build(BuildContext context) {
    OwnershipService service =
        Provider.of<OwnershipService>(context, listen: true);
    OwnershipModel ownership = service.model.ownership!;
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
                        child: Row(children: [
                          IconButton(
                              icon: Icon(Icons.keyboard_arrow_left),
                              onPressed: () => Navigator.of(context).pop()),
                          Text("Ownership NFT", style: TextStyle(fontSize: 32)),
                        ]),
                      ),
                      const Divider(),
                      Text(Bytes.base64UrlEncode(ownership.transactionId!)),
                      const Divider(),
                      Text(ownership.source),
                      const Divider(),
                      Text(ownership.type.toString()),
                      const Divider(),
                      Text(ownership.origin),
                      const Divider(),
                      Text(ownership.contains.join(", ")),
                      const Divider(),
                      Text(ownership.about ?? ""),
                      const Divider(),
                    ]))));
  }
}
