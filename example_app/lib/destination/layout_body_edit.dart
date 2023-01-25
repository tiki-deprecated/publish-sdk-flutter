import 'package:example_app/destination/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class DestinationLayoutBodyEdit extends StatelessWidget {
  DestinationLayoutBodyEdit({super.key});

  final TextEditingController bodyEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DestinationService service =
        Provider.of<DestinationService>(context, listen: true);
    DestinationModel model = service.model;
    bodyEditingController.text = model.body;
    bodyEditingController.selection =
        TextSelection.collapsed(offset: bodyEditingController.text.length);
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
                          Text("Body", style: TextStyle(fontSize: 32)),
                        ]),
                      ),
                      Expanded(
                          child: Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(),
                                color: Colors.white,
                              ),
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller: bodyEditingController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Body",
                                ),
                                onChanged: (newBody) {
                                  bodyEditingController.text = newBody;
                                  model.body = newBody;
                                  service.controller
                                      .updateDestination(model, context);
                                },
                              ))),
                    ]))));
  }
}
