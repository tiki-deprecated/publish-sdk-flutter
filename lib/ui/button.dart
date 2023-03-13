/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// {@category UI}
import 'package:flutter/material.dart';

import '../tiki_sdk.dart';

/// The TikiSdk UI button.
class Button extends StatelessWidget {
  /// The button's text label .
  final String text;

  /// The function to be called on user tap.
  final Function onTap;

  /// The button's background color.
  late final Color? backgroundColor;

  /// The button's border color.
  late final Color? borderColor;

  /// The button's text color.
  late final Color? textColor;

  /// The font family of the button's text from pubspec.
  late final String? fontFamily;

  /// The package that contains the [fontFamily] assets.
  late final String? fontPackage;

  /// The default constructor for outlined button.
  ///
  /// [TikiSdk.theme] is used for default styling.
  Button(this.text, this.onTap,
      {super.key, textColor, borderColor, fontFamily, fontPackage}) {
    this.fontFamily = fontFamily ?? TikiSdk.instance.activeTheme.fontFamily;
    this.fontPackage = fontPackage ?? TikiSdk.instance.activeTheme.fontPackage;
    this.textColor = textColor ?? TikiSdk.instance.activeTheme.primaryTextColor;
    this.borderColor = borderColor ?? TikiSdk.instance.activeTheme.accentColor;
    backgroundColor = const Color(0xFFFFFFFF);
  }

  /// The constructor for a solid color button.
  ///
  /// [TikiSdk.theme] is used for default styling.
  Button.solid(this.text, this.onTap,
      {super.key, color, fontFamily, fontPackage}) {
    this.fontFamily = fontFamily ?? TikiSdk.instance.activeTheme.fontFamily;
    this.fontPackage = fontPackage ?? TikiSdk.instance.activeTheme.fontPackage;
    backgroundColor = color ?? TikiSdk.instance.activeTheme.accentColor;
    borderColor = borderColor ?? TikiSdk.instance.activeTheme.accentColor;
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: backgroundColor,
            border:
                Border.all(width: 1.0, color: borderColor ?? Colors.black26),
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
      ));
}
