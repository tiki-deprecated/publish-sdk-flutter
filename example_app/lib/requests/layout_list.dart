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
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Requests", style: TextStyle(fontSize: 32)),
          ),
          Expanded(
              child: ListView.separated(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(requests[index].message, maxLines: 1, overflow: TextOverflow.ellipsis),
                leading: Text(requests[index].icon),
                trailing: Text(requests[index].timeStamp),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Body'),
                          content: Text(requests[index].message),
                        );
                      });
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ))
        ]));
  }
}
