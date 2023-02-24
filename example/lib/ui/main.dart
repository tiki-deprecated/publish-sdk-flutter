import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/ui/offer.dart';
import 'package:tiki_sdk_flutter/ui/used_bullet.dart';

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
        home: Scaffold(body: Builder(builder: (BuildContext context) => Center(child: ElevatedButton(
          child: const Text("Start"),
          onPressed: () => start(context),
        ),))));
  }

  start(BuildContext context) {
    showModalBottomSheet<dynamic>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) => DecisionSheet(
          "Trade your IDFA (kind of like a serial # for your phone) for a discount.",
          Image.asset("lib/ui/assets/images/offer_sample.png"),
          [
            UsedBullet("Learn how our ads perform", true),
            UsedBullet("Reach you on other platforms", false),
            UsedBullet("Sold to other companies", false),
          ],
        ));
  }
}

