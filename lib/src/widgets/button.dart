/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// {@category UI}
import 'package:flutter/material.dart';

import '../../tiki_sdk.dart';

class Button extends StatelessWidget {
  final String text;
  final void Function() onTap;
  late final Color backgroundColor;
  late final Color borderColor;
  late final Color textColor;
  late final String? fontFamily;
  late final String? fontPackage;

  Button(this.text, this.onTap)
      : fontFamily = TikiSdk.instance.activeTheme.getFontFamily,
        fontPackage = TikiSdk.instance.activeTheme.getFontPackage,
        textColor = TikiSdk.instance.activeTheme.getPrimaryTextColor,
        borderColor = TikiSdk.instance.activeTheme.getAccentColor,
        backgroundColor = const Color(0xFFFFFFFF);

  Button.solid(this.text, this.onTap)
      : fontFamily = TikiSdk.instance.activeTheme.getFontFamily,
        fontPackage = TikiSdk.instance.activeTheme.getFontPackage,
        textColor = TikiSdk.instance.activeTheme.getPrimaryBackgroundColor,
        backgroundColor = TikiSdk.instance.activeTheme.getAccentColor,
        borderColor = TikiSdk.instance.activeTheme.getAccentColor;

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(width: 1.0, color: borderColor),
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
