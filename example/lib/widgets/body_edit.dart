import 'package:flutter/material.dart';

class BodyEdit extends StatelessWidget {

  final TextEditingController bodyEditingController = TextEditingController();

  BodyEdit(String text, {super.key}){
    bodyEditingController.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                color: const Color(0xFFDDDDDD),
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
                          const Text("Body", style: TextStyle(fontSize: 32)),
                        ]),
                      ),
                      Expanded(
                          child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(),
                                color: Colors.white,
                              ),
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller: bodyEditingController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Body",
                                ),
                                onChanged: (newBody) {
                                  bodyEditingController.text = newBody;
                                  bodyEditingController.selection =
                                      TextSelection.collapsed(offset: bodyEditingController.text.length);
                                },
                              ))),
                    ]))));
  }
}
