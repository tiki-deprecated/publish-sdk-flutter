/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// {@category UI}
import 'package:flutter/material.dart';

import '../../tiki_sdk.dart';

/// The TikiSdk UI button.
class Button extends StatelessWidget {
  /// The button's text label .
  final String text;

  /// The function to be called on user tap.
  final Function onTap;

  /// The button's background color.
  late final Color backgroundColor;

  /// The button's border color.
  late final Color borderColor;

  /// The button's text color.
  late final Color textColor;

  /// The font family of the button's text from pubspec.
  late final String fontFamily;

  /// The package that contains the [fontFamily] assets.
  late final String fontPackage;

  /// The default constructor for outlined button.
  ///
  /// [TikiSdk.theme] is used for default styling.
  Button(this.text, this.onTap) :
    fontFamily = TikiSdk.instance.activeTheme.getFontFamily,
    fontPackage = TikiSdk.instance.activeTheme.getFontPackage,
    textColor = TikiSdk.instance.activeTheme.getPrimaryTextColor,
    borderColor = TikiSdk.instance.activeTheme.getAccentColor,
    backgroundColor = const Color(0xFFFFFFFF);

  /// The constructor for a solid color button.
  ///
  /// [TikiSdk.theme] is used for default styling.
  Button.solid(this.text, this.onTap) :
    fontFamily = TikiSdk.instance.activeTheme.getFontFamily,
    fontPackage = TikiSdk.instance.activeTheme.getFontPackage,
    textColor = TikiSdk.instance.activeTheme.getPrimaryBackgroundColor,
    backgroundColor = TikiSdk.instance.activeTheme.getAccentColor,
    borderColor = TikiSdk.instance.activeTheme.getAccentColor;

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => onTap,
      child: LayoutBuilder(builder: (context, constraints) => Container(
        width: constraints.maxWidth,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: backgroundColor,
            border:
                Border.all(width: 1.0, color: borderColor),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: Text(text,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    height: 1.2,
                    color: textColor,
                    fontFamily: fontFamily,
                    package: fontPackage))),
      )));
}
