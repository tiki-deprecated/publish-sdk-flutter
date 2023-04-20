/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// {@category UI}
import 'package:flutter/cupertino.dart';
import 'package:tiki_sdk_flutter/src/widgets/your_choice.dart';

import '../../tiki_sdk.dart';
import '../../ui/offer.dart';
import 'whoops.dart';

class Ending extends StatelessWidget {
  final Widget title;
  final String message;
  final Widget footnote;

  late final Color primaryTextColor;
  late final Color backgroundColor;
  late final String? fontFamily;
  late final String? fontPackage;

  Ending(this.title, this.message, this.footnote,
      {super.key, fontFamily, fontPackage, primaryTextColor, backgroundColor}) {
    this.primaryTextColor = TikiSdk.instance.activeTheme.getPrimaryTextColor;
    this.backgroundColor = TikiSdk.instance.activeTheme.getPrimaryBackgroundColor;
    this.fontFamily = TikiSdk.instance.activeTheme.getFontFamily;
    this.fontPackage = TikiSdk.instance.activeTheme.getFontPackage;
  }

  Ending.accepted() :
    this.title = YourChoice(),
    this.message = "Awesome! You’re in",
    this.footnote = Container(),
    this.primaryTextColor = TikiSdk.instance.activeTheme.getPrimaryTextColor,
    this.backgroundColor = TikiSdk.instance.activeTheme.getPrimaryBackgroundColor,
    this.fontFamily = TikiSdk.instance.activeTheme.getFontFamily,
    this.fontPackage = TikiSdk.instance.activeTheme.getFontPackage;

  Ending.declined() :
        this.title = YourChoice(),
        this.message = "Backing Off",
        this.footnote = Container(),
        this.primaryTextColor = TikiSdk.instance.activeTheme.getPrimaryTextColor,
        this.backgroundColor = TikiSdk.instance.activeTheme.getPrimaryBackgroundColor,
        this.fontFamily = TikiSdk.instance.activeTheme.getFontFamily,
        this.fontPackage = TikiSdk.instance.activeTheme.getFontPackage;

  Ending.error() :
        this.title = Whoops(),
        this.message = "Permission Required",
        this.footnote = Container(),
        this.primaryTextColor = TikiSdk.instance.activeTheme.getPrimaryTextColor,
        this.backgroundColor = TikiSdk.instance.activeTheme.getPrimaryBackgroundColor,
        this.fontFamily = TikiSdk.instance.activeTheme.getFontFamily,
        this.fontPackage = TikiSdk.instance.activeTheme.getFontPackage;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(top: 28.0), child: title),
              Padding(
                  padding: const EdgeInsets.only(top: 36.0),
                  child: Text(message,
                      style: TextStyle(
                          fontFamily: fontFamily,
                          package: fontPackage,
                          fontSize: 32,
                          height: 1.3125,
                          fontWeight: FontWeight.bold,
                          color: primaryTextColor))),
              Padding(
                  padding: const EdgeInsets.only(top: 36.0), child: footnote),
            ]));
  }

  static Future<LicenseRecord> license(Offer offer, bool accepted) async {
    return await TikiSdk.license(offer.getPtr, offer.getUses, offer.getTerms);
  }

}
