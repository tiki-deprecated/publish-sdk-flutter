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
  const MarkdownViewer(this.mdText, {super.key});

  @override
  Widget build(BuildContext context) => Markdown(
      data: mdText,
      styleSheet: MarkdownStyleSheet.fromTheme(ThemeData(
          colorScheme: ColorScheme.light(
              background: TikiSdk.instance.activeTheme.getPrimaryBackgroundColor
          ),
          textTheme: TextTheme(
              bodyMedium: TextStyle(
                fontSize: 16.0,
                color: TikiSdk.instance.activeTheme.getPrimaryTextColor,
                fontFamily: TikiSdk.instance.activeTheme.getFontFamily,
                package: TikiSdk.instance.activeTheme.getFontPackage)))));
}
