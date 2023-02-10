import 'package:example/consent/service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tiki_sdk_flutter/main.dart';

class ConsentLayoutDetail extends StatelessWidget {
  const ConsentLayoutDetail({super.key});

  @override
  Widget build(BuildContext context) {
    ConsentService service = Provider.of<ConsentService>(context, listen: true);
    ConsentModel consent = service.model.consent!;
    return Scaffold(
        body: SafeArea(
            child: Container(
                color: const Color(0xFFDDDDDD),
                height: double.infinity,
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                        child: Row(children: [
                          IconButton(
                            icon: const Icon(Icons.keyboard_arrow_left),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          const Text("Consent NFT",
                              style: TextStyle(fontSize: 32)),
                        ]),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: Text("Hash",
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(Bytes.base64UrlEncode(
                                              consent.transactionId!)))
                                    ]),
                                const Divider(),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: Text("Ownership Id",
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(Bytes.base64UrlEncode(
                                              consent.ownershipId)))
                                    ]),
                                const Divider(),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: Text("Paths",
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(consent.destination.paths
                                              .join(", ")))
                                    ]),
                                const Divider(),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: Text("Uses",
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(consent.destination.uses
                                              .join(", ")))
                                    ]),
                                const Divider(),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: Text("About",
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(consent.about ?? ""))
                                    ]),
                                const Divider(),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: Text("Reward",
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(consent.reward ?? ""))
                                    ]),
                                const Divider(),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: Text("Expiration",
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(consent.expiry == null
                                              ? "No expiration"
                                              : DateFormat("dd-MM-yy hh:mm:ss")
                                                  .format(consent.expiry!)))
                                    ]),
                              ]))
                    ])))));
  }
}
