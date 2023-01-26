import 'package:example_app/destination/service.dart';
import 'package:example_app/requests/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class DestinationLayoutEdit extends StatelessWidget {
  DestinationLayoutEdit({super.key});

  final List<String> secondsList = [
    "1 second",
    "15 seconds",
    "30 seconds",
    "60 seconds"
  ];

  final List<int> secondsValues = [1, 15, 30, 60];

  final TextEditingController urlEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DestinationService service =
        Provider.of<DestinationService>(context, listen: true);
    DestinationModel model = service.model;
    urlEditingController.text = model.url;
    urlEditingController.selection =
        TextSelection.collapsed(offset: urlEditingController.text.length);
    return Scaffold(
        body: WillPopScope(
            onWillPop: () async {
              RequestsService requestsService =
                  Provider.of<RequestsService>(context);
              requestsService.controller.stopTimer(context);
              Navigator.pop(context, false);
              return false;
            },
            child: SafeArea(
                child: Container(
                    color: const Color(0xFFDDDDDD),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 16.0),
                            child: Row(children: [
                              IconButton(
                                icon: const Icon(Icons.keyboard_arrow_left),
                                onPressed: () {
                                  service.controller
                                      .updateDestination(model, context);
                                  Navigator.of(context).pop();
                                },
                              ),
                              const Text("Destination",
                                  style: TextStyle(fontSize: 32)),
                            ]),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(8.0),
                              margin: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                TextField(
                                  controller: urlEditingController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'URL',
                                  ),
                                  onChanged: (newUrl) {
                                    urlEditingController.text = newUrl;
                                    model.url = newUrl;
                                    service.controller
                                        .updateDestination(model, context);
                                  },
                                ),
                                const Divider(),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text("HTTP Method"),
                                      DropdownButton<String>(
                                        value: model.httpMethod,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        elevation: 16,
                                        underline: Container(),
                                        onChanged: (newMethod) {
                                          model.httpMethod = newMethod!;
                                          service.controller.updateDestination(
                                              model, context);
                                        },
                                        items: ["POST", "GET"]
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      )
                                    ]),
                                const Divider(),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text("Interval"),
                                      DropdownButton<String>(
                                        value: secondsList[secondsValues
                                            .indexOf(model.interval)],
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        elevation: 16,
                                        underline: Container(),
                                        onChanged: (newInterval) {
                                          model.interval = secondsValues[
                                              secondsList
                                                  .indexOf(newInterval!)];
                                          RequestsService requestsService =
                                              Provider.of<RequestsService>(
                                                  context,
                                                  listen: false);
                                          requestsService.controller
                                              .stopTimer(context);
                                          service.controller.updateDestination(
                                              model, context);
                                        },
                                        items: secondsList
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      )
                                    ])
                              ]))
                        ])))));
  }
}
