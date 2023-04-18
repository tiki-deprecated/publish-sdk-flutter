/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// {@category UI}
import 'package:flutter/material.dart';

import '../../tiki_sdk.dart';
import 'markdown.dart';

/// The Learn More screen with user information of how TIKI SDK works.
class LearnMore extends StatelessWidget {
  /// The source asset for the Learn More text.
  final String src;

  late final Color? textColor;
  late final Color? backgroundColor;
  late final String? fontFamily;
  late final String? fontPackage;

  /// Builds the Learn More screen.
  ///
  /// [TikiSdk.theme] is used for default styling.
  LearnMore(this.src,
      {super.key, textColor, backgroundColor, fontFamily, fontPackage}) {
    this.textColor = TikiSdk.instance.activeTheme.getPrimaryTextColor;
    this.backgroundColor = TikiSdk.instance.activeTheme.getPrimaryBackgroundColor;
    this.fontFamily = TikiSdk.instance.activeTheme.getFontFamily;
    this.fontPackage = TikiSdk.instance.activeTheme.getFontPackage;
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
            title: const Text("Learn More"),
          ),
          body: SafeArea(
              child: Column(children: [
            Expanded(
              child: FutureBuilder(
                  future: DefaultAssetBundle.of(context).loadString(src),
                  builder: (context, snapshot) {
                    return MarkdownViewer(snapshot.data!);
                  }),
            ),
          ]))));
}
