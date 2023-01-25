import 'package:example_app/destination/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'layout_body_edit.dart';

class DestinationLayoutBodyBtn extends StatelessWidget {
  const DestinationLayoutBodyBtn({super.key});

  @override
  Widget build(BuildContext context) {
    DestinationService service =
        Provider.of<DestinationService>(context, listen: true);
    return Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: const Color(0xFFDDDDDD)),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: GestureDetector(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(child: Text("Body")),
                    Icon(Icons.arrow_forward)
                  ]),
              const Padding(padding: EdgeInsets.all(8.0)),
              Text(
                service.model.body,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ]),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider.value(
                    value: service, child: DestinationLayoutBodyEdit())))));
  }
}