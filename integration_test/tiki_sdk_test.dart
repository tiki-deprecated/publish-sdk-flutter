import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiki_sdk_dart/cache/license/license_usecase.dart';
import 'package:tiki_sdk_dart/cache/license/license_usecase_enum.dart';
import 'package:tiki_sdk_dart/cache/title/title_tag.dart';
import 'package:tiki_sdk_dart/cache/title/title_tag_enum.dart';
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

  test('Tiki SDK config', () async {
    String id = Uuid().v4();
    TikiSdk.config()
      .theme
          .primaryTextColor(Colors.black)
          .primaryBackgroundColor(Colors.white)
          .accentColor(Colors.green)
          .and()
      .dark
          .primaryTextColor(Colors.white)
          .primaryBackgroundColor(Colors.black)
          .accentColor(Colors.green)
          .and()
      .offer
          .bullet("Use for ads", true)
          .bullet("Share with 3rd party", false)
          .bullet("Sell to other companies", true)
          .ptr("offer1")
          .use([LicenseUsecase(LicenseUsecaseEnum.support)])
          .tag(TitleTag(TitleTagEnum.advertisingData))
          .duration(Duration(days: 365))
          .permission(Permission.camera)
          .terms("terms")
          .add()
      .onAccept((offer, license) => print(offer))
      .onDecline((offer, license) => print(offer))
      .disableAcceptEnding(false)
      .disableDeclineEnding(true)
      .initialize(publishingId, id, onComplete: () => print("ok"));
    assert(TikiSdk.instance.address != null);
  });
}
