import 'package:example/home.dart';
import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/main.dart';

const String origin = "com.mytiki.tiki_sdk_example";
const String publishingId = "2b8de004-cbe0-4bd5-bda6-b266d54f5c90";

void main() async {
  TikiSdk tikiSdk = await (TikiSdkFlutterBuilder()..publishingId(publishingId)..origin(origin)).build();
  runApp(MyApp(tikiSdk));
}

class MyApp extends StatelessWidget {
  final TikiSdk initialTikiSdk;

  const MyApp(this.initialTikiSdk, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TIKI SDK Example App',
        home: Scaffold(body: HomeWidget(initialTikiSdk, publishingId, origin)));
  }
}