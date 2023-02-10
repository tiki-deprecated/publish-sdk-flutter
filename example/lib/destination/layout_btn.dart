import 'package:example/destination/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../requests/service.dart';
import 'layout_edit.dart';

class DestinationLayoutBtn extends StatelessWidget {
  const DestinationLayoutBtn({super.key});

  @override
  Widget build(BuildContext context) {
    DestinationService service =
        Provider.of<DestinationService>(context, listen: true);
    RequestsService requestsService =
        Provider.of<RequestsService>(context, listen: false);
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
                      "Destination",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    Icon(Icons.keyboard_arrow_right)
                  ]),
              const Padding(padding: EdgeInsets.all(8.0)),
              Text("${service.model.httpMethod} ${service.model.url}")
            ]),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MultiProvider(providers: [
                      ChangeNotifierProvider<RequestsService>.value(
                          value: requestsService),
                      ChangeNotifierProvider.value(value: service)
                    ], child: DestinationLayoutEdit())))));
  }
}
