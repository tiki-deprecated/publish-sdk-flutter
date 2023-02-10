import 'package:flutter/material.dart';

import 'body_edit.dart';

class BodyCard extends StatefulWidget {
  String body;

  BodyCard(this.body, {super.key});

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
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                        child: Text(
                      "Body",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    Icon(Icons.keyboard_arrow_right)
                  ]),
              const Padding(padding: EdgeInsets.all(8.0)),
              Text(
                widget.body,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ]),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BodyEdit(widget.body)))));
  }
}
