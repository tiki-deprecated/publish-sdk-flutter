import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/main.dart';

const String origin = "com.mytiki.tiki_sdk_example";
const String publishingId = "e12f5b7b-6b48-4503-8b39-28e4995b5f88";

void main() async {
  TikiSdk tikiSdk = await (TikiSdkBuilder()..publishingId(publishingId)..origin(origin)).build();
  runApp(MyApp(tikiSdk));
}

class MyApp extends StatelessWidget {
  final TikiSdk initialTikiSdk;

  const MyApp(this.initialTikiSdk, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TIKI SDK Example App',
        home: Scaffold(body: Column(
          children: [
            ElevatedButton(onPressed:
                TikiSdk.present(context), child: Text("Start")),
            ElevatedButton(onPressed:
                TikiSdk.settings(context), child: Text("Settings"))
          ],
        )));
  }
}
