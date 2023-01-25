import 'package:example_app/consent/service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tiki_sdk_flutter/main.dart';

class ConsentLayoutDetail extends StatelessWidget {
  const ConsentLayoutDetail({super.key});

  @override
  Widget build(BuildContext context) {
    ConsentService service =
        Provider.of<ConsentService>(context, listen: true);
    ConsentModel consent = service.model.consent!;
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                        child: Row(children: [
                          IconButton(
                              icon: const Icon(Icons.keyboard_arrow_left),
                              onPressed: () => Navigator.of(context).pop()),
                          const Text("Consent NFT", style: TextStyle(fontSize: 32)),
                        ]),
                      ),
                      const Divider(),
                      Text(Bytes.base64UrlEncode(consent.transactionId!)),
                      const Divider(),
                      Text(Bytes.base64UrlEncode(consent.ownershipId)),
                      const Divider(),
                      Text(consent.destination.paths.join(", ")),
                      const Divider(),
                      Text(consent.destination.uses.join(", ")),
                      const Divider(),
                      Text(consent.about ?? ""),
                      const Divider(),
                      Text(consent.reward ?? ""),
                      const Divider(),
                      Text(DateFormat("dd-MM-yy hh:mm:ss").format(consent.expiry!)),
                    ]))));
  }
}
