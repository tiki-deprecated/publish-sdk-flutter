import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiki_sdk_flutter/tiki_sdk.dart';

const String origin = "com.mytiki.tiki_sdk_example";
const String publishingId = "e12f5b7b-6b48-4503-8b39-28e4995b5f88";

void main() async {
  await TikiSdk.config()
      .theme
        .fontFamily("SpaceGrotesk")
        .fontPackage("tiki_sdk_flutter")
        .and()
      .offer
        .reward(Image.asset("lib/ui/assets/images/offer_sample.png"))
        .ptr("test_offer")
        .bullet("Learn how our ads perform ", true)
        .bullet("Reach you on other platforms", false)
        .bullet("Sold to other companies", false)
        .use([LicenseUsecase.support()])
        .tag(TitleTag.advertisingData())
        .description("Trade your IDFA (kind of like a serial # for your phone) for a discount.")
        .terms("lib/ui/assets/terms.md")
        .permission(Permission.camera)
        .duration(const Duration(days: 365))
        .add()
      .initialize(publishingId, "test_user_123", onComplete: () =>
    runApp(const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'TIKI SDK Example App',
        home: Scaffold(body: Center(child: ExampleButtons())));
  }
}

class ExampleButtons extends StatelessWidget{
  const ExampleButtons({super.key});

  @override
  Widget build(BuildContext context) =>  Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      ElevatedButton(onPressed:
          () => TikiSdk.present(context), child: const Text("Start")),
      ElevatedButton(onPressed:
          () => TikiSdk.settings(context), child: const Text("Settings"))
    ],
  );
}
