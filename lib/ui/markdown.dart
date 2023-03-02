/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
/// {@category UI}
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

/// A simple Markdown viewer.
class MarkdownViewer extends StatelessWidget {
  /// The markdown text to be displayed.
  final String mdText;

  final double fontSize;
  final Color? textColor;
  final String? fontPackage;
  final String? fontFamily;

  const MarkdownViewer(this.mdText,
      {super.key,
      this.textColor = Colors.black,
      this.fontSize = 16,
      this.fontFamily = "Roboto",
      this.fontPackage = "tiki_sdk_flutter"});

  @override
  Widget build(BuildContext context) => Markdown(
      data: mdText,
      styleSheet: MarkdownStyleSheet.fromTheme(ThemeData(
          textTheme: TextTheme(
              bodyText2: TextStyle(fontSize: 20.0, color: textColor)))));
}
