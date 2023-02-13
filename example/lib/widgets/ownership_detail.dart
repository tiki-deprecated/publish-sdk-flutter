import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/main.dart';

class OwnershipDetail extends StatelessWidget {
  final OwnershipModel ownership;

  const OwnershipDetail(this.ownership, {super.key});

  @override
  Widget build(BuildContext context) {
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
                          const Text("Ownership NFT",
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
                                              ownership.transactionId!)))
                                    ]),
                                const Divider(),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: Text("Source",
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(ownership.source))
                                    ]),
                                const Divider(),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: Text("Type",
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child:
                                              Text(ownership.type.toString()))
                                    ]),
                                const Divider(),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: Text("Origin",
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(ownership.origin))
                                    ]),
                                const Divider(),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: Text("Contains",
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Text(
                                              ownership.contains.join(", ")))
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
                                          child: Text(ownership.about ?? ""))
                                    ]),
                                const Divider(),
                              ]))
                    ])))));
  }
}
