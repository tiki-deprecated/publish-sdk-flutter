import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/tiki_sdk.dart';

const String origin = "com.mytiki.tiki_sdk_example";
const String publishingId = "e12f5b7b-6b48-4503-8b39-28e4995b5f88";

void main() async {
  await TikiSdk.config().initialize(publishingId, "test_user_123", onComplete: () =>
    runApp(const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TIKI SDK Example App',
        home: Scaffold(body: Column(
          children: [
            ElevatedButton(onPressed:
              () => TikiSdk.present(context), child: const Text("Start")),
            ElevatedButton(onPressed:
              () => TikiSdk.settings(context), child: const Text("Settings"))
          ],
        )));
  }
}
