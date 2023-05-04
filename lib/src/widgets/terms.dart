/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// {@category UI}
import 'package:flutter/material.dart';

import '../../tiki_sdk.dart';
import 'button.dart';
import 'markdown.dart';
import 'navigation_header.dart';

class Terms extends StatelessWidget {
  late final String text;

  late final Color? buttonColor;
  late final Color? textColor;
  late final Color? backgroundColor;

  late final String? fontFamily;
  late final String? fontPackage;

  Terms(this.text,{
    Color? buttonColor,
    Color? textColor,
    Color? backgroundColor,
    String? fontFamily,
    String? fontPackage,
  }) {
    this.buttonColor = buttonColor ?? TikiSdk.instance.activeTheme.getAccentColor;
    this.textColor = textColor ?? TikiSdk.instance.activeTheme.getPrimaryTextColor;
    this.backgroundColor =
backgroundColor ??         TikiSdk.instance.activeTheme.getPrimaryBackgroundColor;
    this.fontFamily = fontFamily ?? TikiSdk.instance.activeTheme.getFontFamily;
    this.fontPackage = fontPackage ?? TikiSdk.instance.activeTheme.getFontPackage;
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop(false);
        return Future.value(false);
      },
      child: Scaffold(
          appBar: NavigationHeader("Terms and Conditions", context).appBar,
          body: SafeArea(
              child: Column(children: [
            Expanded(child: MarkdownViewer(text)),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: TikiSdk.instance.activeTheme.getAccentColor,
                )),
            Padding(
                padding: const EdgeInsets.only(
                    top: 40, bottom: 20, left: 15, right: 15),
                child: Button.solid("I agree", () {
                  Navigator.of(context).pop(true);
                }))
          ]))));
}
