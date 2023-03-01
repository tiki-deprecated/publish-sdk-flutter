/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
/// {@category UI}
import 'package:flutter/material.dart';
import '../tiki_sdk.dart';
import 'button.dart';
import 'markdown.dart';

class Terms extends StatelessWidget {

  late final String src;

  late final Color? buttonColor;
  late final Color? textColor;
  late final Color? backgroundColor;

  late final String? fontFamily;
  late final String? fontPackage;

  Terms(this.src, {super.key,
        buttonColor,
        textColor,
        backgroundColor,
        fontFamily,
        fontPackage}){
    this.buttonColor = buttonColor ?? TikiSdk.theme.accentColor;
    this.textColor = textColor ?? TikiSdk.theme.primaryTextColor;
    this.backgroundColor = backgroundColor ?? TikiSdk.theme.primaryBackgroundColor;
    this.fontFamily = fontFamily ?? TikiSdk.theme.fontFamily;
    this.fontPackage = fontPackage ?? TikiSdk.theme.fontPackage;
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop(false);
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop()),
            title: const Text("Terms and Conditions"),
          ),
          body: SafeArea(
              child: Column(children: [
                Expanded(
                  child: FutureBuilder(
                      future: DefaultAssetBundle.of(context).loadString(src),
                      builder: (context, snapshot) {
                        return MarkdownViewer(snapshot.data!,
                            textColor: textColor,
                            fontSize: 20,
                            fontPackage: fontPackage,
                            fontFamily: fontFamily);
                      }),
                ),
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 40, bottom: 50, left: 15, right: 15),
                      child: Button.solid("I agree", () {
                        Navigator.of(context).pop(true);
                      }, color: buttonColor))
              ]))));
}