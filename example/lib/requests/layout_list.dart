import 'package:example/requests/req_model.dart';
import 'package:example/requests/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../destination/model.dart';
import '../destination/service.dart';

class RequestsLayoutList extends StatelessWidget {
  const RequestsLayoutList({super.key});

  @override
  Widget build(BuildContext context) {
    RequestsService service =
        Provider.of<RequestsService>(context, listen: true);
    DestinationModel destination =
        Provider.of<DestinationService>(context, listen: true).model;
    List<RequestModel> requests = service.model.log;
    service.controller.startTimer(context, destination);
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
