import 'package:flutter/material.dart';

const String origin = "com.mytiki.tiki_sdk_example";
const String publishingId = "e12f5b7b-6b48-4503-8b39-28e4995b5f88";

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TIKI SDK UI Example App',
        home: Scaffold(body: Builder(builder: (BuildContext context) => const Center(child: ElevatedButton(
          onPressed: null,
          child: Text("Start"),
        ),))));
  }
}

