import 'package:flutter/material.dart';

import '../request.dart';

class RequestList extends StatelessWidget {
  final List<Request> requests;

  const RequestList(this.requests, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1.0, color: const Color(0xFFCCCCCC)),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  "Requests",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ...requests.reversed.map((request) {
                return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          title: Text(request.message,
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                          leading: Text(request.icon),
                          trailing: Text(request.timeStamp),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Body'),
                                    content: Text(request.message),
                                  );
                                });
                          }),
                      if (requests.indexOf(request) != 0) const Divider()
                    ]);
              })
            ]));
  }
}
