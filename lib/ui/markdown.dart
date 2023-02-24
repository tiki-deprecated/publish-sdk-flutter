import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownViewer extends StatelessWidget{

  final Color? textColor;
  final double fontSize;
  final String? fontPackage;
  final String? fontFamily;

  final String asset;

  const MarkdownViewer(this.asset, {super.key,
    this.textColor = Colors.black,
    this.fontSize = 16, this.fontFamily, this.fontPackage});

  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: DefaultAssetBundle.of(context).loadString(asset),
    builder: (context, snapshot) => Markdown(
      data: snapshot.data!,
      styleSheet: MarkdownStyleSheet.fromTheme(ThemeData(
          textTheme: TextTheme(
              bodyText2: TextStyle(
                  fontSize: 20.0, color: textColor))))));
}