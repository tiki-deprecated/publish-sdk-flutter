import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiki_sdk_flutter/tiki_sdk.dart';
import 'package:tiki_sdk_flutter/ui/used_bullet.dart';

import 'tiki_credentials.dart' as credentials;

void main() {
  String publishingId = credentials.publishingId;

  test('Tiki SDK init', () async {
    TikiSdk tikiSdk = await TikiSdk.config().init(publishingId);
    assert(tikiSdk.address != null);
  });

  test('Tiki SDK config', () async {
    TikiSdk tikiSdk = await TikiSdk.config()
        .theme
          .setPrimaryTextColor(Colors.white)
          .setPrimaryBackgroundColor(Colors.white)
          .setSecondaryBackgroundColor(Colors.white)
          .setAccentColor(Colors.white)
          .setFontFamily("test")
          .setFontPackage("test")
          .and()
        .dark
          .setPrimaryTextColor(Colors.white)
          .setPrimaryBackgroundColor(Colors.white)
          .setSecondaryBackgroundColor(Colors.white)
          .setAccentColor(Colors.white)
          .setFontFamily("test")
          .setFontPackage("test")
          .and()
        .offer
          .setId("randomId")
          .setReward(Image.network("https://via.placeholder.com/300x86"))
          .addUsedBullet(UsedBullet("test 1", true))
          .addUsedBullet(UsedBullet("test 2", false))
          .addUsedBullet(UsedBullet("test 3", true))
          .setPtr("source")
          .setDescription("testing")
          .setTerms("path/terms.md")
          .addUse("tbd uses")
          .addTag("tbd tags")
          .setExpiry(DateTime.now().add(const Duration(days: 365)))
          .addReqPermission(Permission.camera)
          .add()
        .offer
          .setId("randomId2")
          .setReward(Image.network("https://via.placeholder.com/300x86"))
          .addUsedBullet(UsedBullet("test 1", true))
          .addUsedBullet(UsedBullet("test 2", true))
          .addUsedBullet(UsedBullet("test 3", true))
          .setPtr("source")
          .setDescription("testing2")
          .setTerms("path/terms.md")
          .addUse("tbd uses")
          .addTag("tbd tags")
          .setExpiry(DateTime.now().add(const Duration(days: 365)))
          .addReqPermission(Permission.camera)
          .addReqPermission(Permission.location)
          .add()
        .setOnAccept((offer) => null)
        .setOnDecline((offer) => null)
        .setOnSettings((offer) => null)
        .disableAcceptEnding(false)
        .disableDeclineEnding(true)
        .init(publishingId);
    assert(tikiSdk.address != null);
  });
}
