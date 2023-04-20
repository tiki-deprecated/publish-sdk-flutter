/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// {@category UI}
import 'package:flutter/cupertino.dart';
import 'package:tiki_sdk_flutter/ui/bullet.dart';

import '../../src/assets/icons/tiki_sdk_icons_icons.dart';
import '../../tiki_sdk.dart';

class UsedFor extends StatelessWidget {
  final List<Bullet> bullets;

  late final Color? textColor;
  late final String? fontFamily;
  late final String? fontPackage;

  UsedFor(this.bullets, {super.key, textColor, fontFamily, fontPackage}) {
    this.textColor =
        textColor ?? TikiSdk.instance.activeTheme.getPrimaryTextColor;
    this.fontFamily = fontFamily ?? TikiSdk.instance.activeTheme.getFontFamily;
    this.fontPackage =
        fontPackage ?? TikiSdk.instance.activeTheme.getFontPackage;
  }

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "HOW YOUR DATA WILL BE USED",
                      style: TextStyle(
                          fontFamily: fontFamily,
                          package: fontPackage,
                          fontSize: 16,
                          height: 1.8,
                          fontWeight: FontWeight.bold,
                          color: textColor),
                    ),
                    ...bullets.map((item) => Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Row(children: [
                            Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: item.isUsed
                                    ? const Icon(TikiSdkIcons.check,
                                        color: Color.fromRGBO(0, 178, 114, 1),
                                        size: 12)
                                    : const Icon(TikiSdkIcons.x,
                                        color: Color.fromRGBO(199, 48, 0, 1),
                                        size: 12)),
                            Text(
                              item.text,
                              style: TextStyle(
                                  fontFamily: fontFamily,
                                  package: fontPackage,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: TikiSdk.instance.activeTheme.getSecondaryTextColor),
                            )
                          ]),
                        ))
                  ]))
        ],
      ));
}
