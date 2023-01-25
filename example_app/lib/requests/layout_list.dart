import 'package:example_app/requests/req_model.dart';
import 'package:example_app/requests/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestsLayoutList extends StatelessWidget {
  const RequestsLayoutList({super.key});

  @override
  Widget build(BuildContext context) {
    RequestsService service =
        Provider.of<RequestsService>(context, listen: true);
    List<RequestModel> requests = service.model.log;
    service.controller.startTimer(context);
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: const Color(0xFFDDDDDD)),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text("Requests", style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          ...requests.map((request) {
              return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(request.message, maxLines: 1, overflow: TextOverflow.ellipsis),
                  leading: Text(request.icon),
                  trailing: Text(request.timeStamp),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Body'),
                            content: Text(request.message),
                          );
                        });
                  }),
                if(requests.indexOf(request) < requests.length-1) Divider()
            ]);
          })
        ]));
  }
}
