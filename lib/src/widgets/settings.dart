/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// {@category UI}
import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/tiki_sdk.dart';

import '../../ui/offer.dart';
import 'button.dart';
import 'learn_more_btn.dart';
import 'markdown.dart';
import 'offer_card.dart';
import 'used_for.dart';

class Settings extends StatefulWidget {

  late final Color primaryTextColor;
  late final Color secondaryTextColor;
  late final Color btnOutlineTextColor;
  late final Color btnOutlineBorderColor;
  late final Color btnSolidColor;

  late final String? fontPackage;
  late final String? fontFamily;

  final bool isAccepted;

  Settings(this.isAccepted) {
    primaryTextColor = TikiSdk.instance.activeTheme.getPrimaryTextColor;
    secondaryTextColor =
        TikiSdk.instance.activeTheme.getSecondaryTextColor;
    btnOutlineTextColor =
        TikiSdk.instance.activeTheme.getPrimaryTextColor;
    btnOutlineBorderColor =
         TikiSdk.instance.activeTheme.getAccentColor;
    btnSolidColor =
         TikiSdk.instance.activeTheme.getAccentColor;
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
    isAccepted = widget.isAccepted;
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
        title: Text("Settings"),
        actions: [LearnMoreButton()],
      ),
      body: SafeArea(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(children: [
            OfferCard(TikiSdk.instance.offers.values.first),
            UsedFor(
                TikiSdk.instance.offers.values.first.getBullets)
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
        ),
        const Text("Terms and Conditions"),
        Expanded(child:MarkdownViewer(
            TikiSdk.instance.offers.values.first.getTerms)),
        Padding(
            padding: const EdgeInsets.only(top: 30.0),
        ),
        isAccepted
                ? Button(
                    "Opt Out",
                    _change,
                  )
                : Button.solid("Opt In", _change)
      ])));

  Future<void> _change() async {
    setState((){
      isAccepted = !isAccepted;
      license(TikiSdk.instance.offers.values.first);
    });

  }

  Future<void> license(Offer offer) async {
    LicenseRecord license = await TikiSdk.license(offer.getPtr, offer.getUses, offer.getTerms);
    if(TikiSdk.instance.getOnAccept != null) TikiSdk.instance.getOnAccept!(offer, license);
  }
}
