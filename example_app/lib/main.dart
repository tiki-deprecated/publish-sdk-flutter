import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'destination/layout_ body_btn.dart';
import 'destination/service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DestinationService destinationService = DestinationService();

    return MaterialApp(
        title: 'TIKI SDK Example App',
        home: Scaffold(
            body: Center(
                child: ChangeNotifierProvider<DestinationService>.value(
                    value: destinationService,
                    child: const DestinationLayoutBodyBtn()))));
  }
}
