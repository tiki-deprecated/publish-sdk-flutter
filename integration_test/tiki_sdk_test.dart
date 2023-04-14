import 'package:flutter_test/flutter_test.dart';
import 'package:tiki_sdk_flutter/tiki_sdk.dart';
import 'package:uuid/uuid.dart';

import 'tiki_credentials.dart' as credentials;

void main() {
  String publishingId = credentials.publishingId;
  String id = Uuid().v4();

  test('Tiki SDK init', () async {
    await TikiSdk.config().initialize(publishingId, id);
    assert(TikiSdk.instance.address != null);
  });

  // test('Tiki SDK config', () async {
  //   String id = Uuid().v4();
  //   // TikiSdk.config()
  //   //   .theme
  //   //       .primaryTextColor(Colors.black)
  //   //       .primaryBackgroundColor(Colors.white)
  //   //       .accentColor(Colors.green)
  //   //       .and()
  //   //   .dark
  //   //       .primaryTextColor(Colors.white)
  //   //       .primaryBackgroundColor(Colors.black)
  //   //       .accentColor(Colors.green)
  //   //       .and()
  //   //   .offer
  //   //       .bullet(text: "Use for ads", isUsed: true)
  //   //       .bullet(text: "Share with 3rd party", isUsed: false)
  //   //       .bullet(text: "Sell to other companies", isUsed: true)
  //   //       .ptr("offer1")
  //   //       .use(usecases: [LicenseUsecase(LicenseUsecaseEnum.support)])
  //   //       .tag(TitleTag(TitleTagEnum.advertisingData))
  //   //       .duration(365 * 24 * 60 * 60)
  //   //       .permission(Permission.camera)
  //   //       .terms("terms.md")
  //   //       .add()
  //   //   .onAccept((offer, license) => print(offer))
  //   //   .onDecline((offer, license) => print(offer))
  //   //   .disableAcceptEnding(false)
  //   //   .disableDeclineEnding(true)
  //   //   .initialize(publishingId: publishingId, id:id, onComplete: () => print("ok"));
  //   assert(TikiSdk.instance.address != null);
  // });
}
