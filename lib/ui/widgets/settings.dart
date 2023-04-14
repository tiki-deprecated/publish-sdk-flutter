/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// {@category UI}
import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/tiki_sdk.dart';

import 'button.dart';
import 'learn_more_btn.dart';
import 'markdown.dart';
import 'offer_card.dart';
import 'used_for.dart';

/// The settings UI that shows the [offers] and let the user update its preferences.
class Settings extends StatefulWidget {
  /// A title to be shown in the top of the screen.
  final RichText? title;

  late final Color primaryTextColor;
  late final Color secondaryTextColor;
  late final Color btnOutlineTextColor;
  late final Color btnOutlineBorderColor;
  late final Color btnSolidColor;

  late final String? fontPackage;
  late final String? fontFamily;

  /// Builds the settings screen.
  ///
  /// [TikiSdk.theme] is used for default styling.
  Settings({
    super.key,
    this.title,
    Color? primaryTextColor,
    Color? secondaryTextColor,
    Color? btnOutlineTextColor,
    Color? btnOutlineBorderColor,
    Color? btnSolidColor,
    String? fontPackage,
    String? fontFamily,
  }) {
    primaryTextColor =
        primaryTextColor ?? TikiSdk.instance.activeTheme.primaryTextColor;
    secondaryTextColor =
        secondaryTextColor ?? TikiSdk.instance.activeTheme.secondaryTextColor;
    btnOutlineTextColor =
        btnOutlineTextColor ?? TikiSdk.instance.activeTheme.primaryTextColor;
    btnOutlineBorderColor =
        btnOutlineBorderColor ?? TikiSdk.instance.activeTheme.accentColor;
    btnSolidColor = btnSolidColor ?? TikiSdk.instance.activeTheme.accentColor;
    fontPackage = fontPackage ?? TikiSdk.instance.activeTheme.fontPackage;
    fontFamily = fontFamily ?? TikiSdk.instance.activeTheme.fontFamily;
  }

  @override
  State<StatefulWidget> createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  int offerIndex = 0;
  bool isAccepted = false;

  String defaultTerms = "path to default terms";

  @override
  void initState() {
    // TODO VERIFY LICENSE STATUS
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop()),
        title: widget.title,
        actions: [
          LearnMoreButton(
            iconColor: widget.secondaryTextColor,
          )
        ],
      ),
      body: SafeArea(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(children: [
            OfferCard(TikiSdk.instance.offers.values.toList()[offerIndex]),
            UsedFor(
                TikiSdk.instance.offers.values.toList()[offerIndex].usedBullet)
          ]),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Terms and Conditions"),
                MarkdownViewer(
                    TikiSdk.instance.offers.values.toList()[offerIndex].terms)
              ],
            )),
        Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: isAccepted
                ? Button(
                    "Opt Out",
                    _change,
                    textColor: widget.btnOutlineTextColor,
                    borderColor: widget.btnOutlineBorderColor,
                    fontFamily: widget.fontFamily,
                    fontPackage: widget.fontPackage,
                  )
                : Button.solid("Opt In", _change,
                    color: widget.btnSolidColor,
                    fontFamily: widget.fontFamily,
                    fontPackage: widget.fontPackage))
      ])));

  Future<void> _change() async {
    // TODO await change license
  }
}
