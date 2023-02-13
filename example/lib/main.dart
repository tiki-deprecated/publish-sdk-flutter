import 'package:example/home.dart';
import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/main.dart';

void main() async {
  const String origin = "com.mytiki.tiki_sdk_example";
  const String apiId = "2b8de004-cbe0-4bd5-bda6-b266d54f5c90";
  TikiSdk tikiSdk = await (TikiSdkFlutterBuilder()..apiId(apiId)..origin(origin)).build();
  runApp(MyApp(tikiSdk));
}

class MyApp extends StatelessWidget {
  final String origin = "com.mytiki.tiki_sdk_example";
  final String apiId = "2b8de004-cbe0-4bd5-bda6-b266d54f5c90";
  final TikiSdk initialTikiSdk;

  const MyApp(this.initialTikiSdk, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TIKI SDK Example App',
        home: Scaffold(body: HomeWidget(initialTikiSdk, apiId, origin)));
  }
}
