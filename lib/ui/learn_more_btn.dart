/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
/// {@category UI}
import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/ui/learn_more.dart';

import '../src/assets/icons/tiki_sdk_icons_icons.dart';
import '../tiki_sdk.dart';

/// A help button that shows the [LearnMore] widget on tap.
///
/// [TikiSdk.theme] is used for default styling.
class LearnMoreButton extends StatelessWidget {

  late final Color? iconColor;
  late final Color? textColor;
  late final Color? backgroundColor;
  late final String? fontFamily;
  late final String? fontPackage;

  LearnMoreButton(
      {super.key,
      iconColor,
      textColor,
      backgroundColor,
      fontFamily,
      fontPackage}){
    iconColor = iconColor ?? TikiSdk.theme.secondaryTextColor;
    textColor = textColor ?? TikiSdk.theme.primaryTextColor;
    backgroundColor = backgroundColor ?? TikiSdk.theme.primaryBackgroundColor;
    fontFamily = fontFamily ?? TikiSdk.theme.fontFamily;
    fontPackage = fontPackage ?? TikiSdk.theme.fontPackage;
  }

  @override
  Widget build(BuildContext context) => IconButton(
      onPressed: null,
      icon: IconButton(
          icon: Icon(TikiSdkIcons.circleQuestion, color: iconColor),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LearnMore("lib/src/assets/data/learn_more.md",
              textColor: textColor,
              backgroundColor: backgroundColor,
              fontFamily: fontFamily,
              fontPackage: fontPackage,)))));
}
