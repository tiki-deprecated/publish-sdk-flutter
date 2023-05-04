/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// {@category UI}
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:tiki_sdk_flutter/tiki_sdk.dart';

class MarkdownViewer extends StatelessWidget {
  final String mdText;
  final double fontSize;
  late final Color backgroundColor;
  late final String fontFamily;
  late final String fontPackage;

  MarkdownViewer(this.mdText, {super.key,
    this.fontSize = 16,
    Color? backgroundColor, String? fontFamily, String? fontPackage}){
    this.backgroundColor = backgroundColor ?? TikiSdk.instance.activeTheme.getPrimaryBackgroundColor;
    this.fontFamily = fontFamily ?? TikiSdk.instance.activeTheme.getFontFamily;
    this.fontPackage = fontPackage ?? TikiSdk.instance.activeTheme.getFontPackage;
  }

  @override
  Widget build(BuildContext context) => Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      color: backgroundColor, child: Markdown(
      data: mdText,
      styleSheet: MarkdownStyleSheet.fromTheme(ThemeData(
          colorScheme: ColorScheme.light(background: backgroundColor),
          textTheme: TextTheme(
              bodyMedium: TextStyle(
                  fontSize: fontSize,
                  fontFamily: fontFamily,
                  package: fontPackage))))));
}
