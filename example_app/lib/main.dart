import 'package:example_app/try_it_out/service.dart';
import 'package:flutter/material.dart';

void main() async {
  TryItOutService service = TryItOutService();
  await service.init();
  runApp(MyApp(service));
}

class MyApp extends StatelessWidget {
  final TryItOutService service;
  const MyApp(this.service, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TIKI SDK Example App',
        home: Scaffold(
            body: service.presenter.tryItOut()));
  }
}
