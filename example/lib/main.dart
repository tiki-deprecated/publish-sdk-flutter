import 'package:example/home.dart';
import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/main.dart';
import 'package:tiki_sdk_flutter/ui/tiki_flow.dart';

const String origin = "com.mytiki.tiki_sdk_example";
const String publishingId = "e12f5b7b-6b48-4503-8b39-28e4995b5f88";

void main() async {
  //TikiSdk tikiSdk = await (TikiSdkFlutterBuilder()..publishingId(publishingId)..origin(origin)).build();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TIKI SDK Example App',
        home: Scaffold(body:
        //HomeWidget(initialTikiSdk, publishingId, origin)));\
        Builder(builder: (BuildContext context) => Center(child: ElevatedButton(
            child: Text("Start flow"),
            onPressed: () => TikiFlow().start(context),
          ),))));
  }
}
