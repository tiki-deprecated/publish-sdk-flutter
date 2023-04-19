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

class Settings extends StatefulWidget {
  final RichText? title;

  late final Color primaryTextColor;
  late final Color secondaryTextColor;
  late final Color btnOutlineTextColor;
  late final Color btnOutlineBorderColor;
  late final Color btnSolidColor;

  late final String? fontPackage;
  late final String? fontFamily;

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
        primaryTextColor ?? TikiSdk.instance.activeTheme.getPrimaryTextColor;
    secondaryTextColor =
        secondaryTextColor ?? TikiSdk.instance.activeTheme.getSecondaryTextColor;
    btnOutlineTextColor =
        btnOutlineTextColor ?? TikiSdk.instance.activeTheme.getPrimaryTextColor;
    btnOutlineBorderColor =
        btnOutlineBorderColor ?? TikiSdk.instance.activeTheme.getAccentColor;
    btnSolidColor = btnSolidColor ?? TikiSdk.instance.activeTheme.getAccentColor;
    fontPackage = TikiSdk.instance.activeTheme.getFontPackage;
    fontFamily = TikiSdk.instance.activeTheme.getFontFamily;
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
        backgroundColor: TikiSdk.instance.theme.getPrimaryBackgroundColor,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: TikiSdk.instance.theme.getPrimaryTextColor,
            onPressed: () => Navigator.of(context).pop()),
        title: Text(
          "Settings"
        ),
        actions: [
          LearnMoreButton()
        ],
      ),
      body: SafeArea(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(children: [
            OfferCard(TikiSdk.instance.offers.values.toList()[offerIndex]),
            UsedFor(
                TikiSdk.instance.offers.values.toList()[offerIndex].getBullets)
          ]),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 30.0),
        ),
        const Text("Terms and Conditions"),
        MarkdownViewer(
                    TikiSdk.instance.offers.values.toList()[offerIndex].getTerms),
        Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: isAccepted
                ? Button(
                    "Opt Out",
                    _change,
                  )
                : Button.solid("Opt In", _change))
      ])));

  Future<void> _change() async {
    // TODO await change license
  }
}
