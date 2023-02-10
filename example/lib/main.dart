import 'package:example/home.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String origin = "com.mytiki.tiki_sdk_example";
  final String apiId = "2b8de004-cbe0-4bd5-bda6-b266d54f5c90";

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TIKI SDK Example App', home: Scaffold(body: HomeWidget(apiId, origin)));
  }
}
