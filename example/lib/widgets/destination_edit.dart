import 'package:flutter/material.dart';

class DestinationEdit extends StatefulWidget {
  final String url;
  final String httpMethod;
  final int interval;

  const DestinationEdit(this.url, this.httpMethod, this.interval, {super.key});

  @override
  State<StatefulWidget> createState() => DestinationEditState();
}

class DestinationEditState extends State<DestinationEdit> {
  late String url;
  late String httpMethod;
  late int interval;

  final List<String> secondsList = [
    "1 second",
    "15 seconds",
    "30 seconds",
    "60 seconds"
  ];

  final List<int> secondsValues = [1, 15, 30, 60];

  final TextEditingController urlEditingController = TextEditingController();

  @override
  void initState() {
    url = widget.url;
    httpMethod = widget.httpMethod;
    interval = widget.interval;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    urlEditingController.selection =
        TextSelection.collapsed(offset: urlEditingController.text.length);
    return Scaffold(
        body: WillPopScope(
            onWillPop: () async {
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
                                    setState(() {
                                      urlEditingController.text = newUrl;
                                      url = newUrl;
                                    });
                                  },
                                ),
                                const Divider(),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text("HTTP Method"),
                                      DropdownButton<String>(
                                        value: httpMethod,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        elevation: 16,
                                        underline: Container(),
                                        onChanged: (newMethod) {
                                          setState(() {
                                            httpMethod = newMethod!;
                                          });
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
                                        value: secondsList[
                                            secondsValues.indexOf(interval)],
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        elevation: 16,
                                        underline: Container(),
                                        onChanged: (newInterval) {
                                          setState(() {
                                            interval = secondsValues[secondsList
                                                .indexOf(newInterval!)];
                                          });
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
