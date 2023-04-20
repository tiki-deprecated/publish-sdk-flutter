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
  final Color backgroundColor;
  const MarkdownViewer(this.mdText, {super.key, this.fontSize = 16, this.backgroundColor = const Color(0xFFFFFFFF)});

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
                  fontFamily: TikiSdk.instance.activeTheme.getFontFamily,
                  package: TikiSdk.instance.activeTheme.getFontPackage))))));
}
