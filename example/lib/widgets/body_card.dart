import 'package:flutter/material.dart';

import 'body_edit.dart';

class BodyCard extends StatefulWidget {
  final String body;
  final void Function(String body) updateBody;

  const BodyCard(this.body, this.updateBody, {super.key});

  @override
  State<StatefulWidget> createState() => BodyCardState();
}

class BodyCardState extends State<BodyCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1.0, color: const Color(0xFFCCCCCC)),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: GestureDetector(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Expanded(
                            child: Text(
                          "Body (JSON)",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        )),
                        Icon(Icons.keyboard_arrow_right)
                      ]),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  Text(
                    widget.body,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 10))
                ]),
            onTap: () async {
              String body = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BodyEdit(widget.body)));
              if (body != widget.body) widget.updateBody(body);
            }));
  }
}
