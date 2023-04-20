/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// {@category UI}
import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/src/widgets/trade_your_data.dart';
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

  final String terms;

  Settings(this.isAccepted, this.terms) {
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
          centerTitle: false,
          leadingWidth: 30,
          elevation: 0,
          backgroundColor:
            TikiSdk.instance.activeTheme.getSecondaryBackgroundColor,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: TikiSdk.instance.activeTheme.getPrimaryTextColor,
              onPressed: () => Navigator.of(context).pop()),
          title: TradeYourData(),
          actions: [ LearnMoreButton()]),
      body: SafeArea( child:
        Container(color: TikiSdk.instance.activeTheme.getSecondaryBackgroundColor,
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            OfferCard(TikiSdk.instance.offers.values.first),
            UsedFor(
                TikiSdk.instance.offers.values.first.getBullets)
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text("Terms & Conditions",
            style: TextStyle(
              fontFamily: widget.fontFamily,
              package: widget.fontPackage,
              fontSize: 16,
              height: 1.8,
              fontWeight: FontWeight.bold,
              color: widget.primaryTextColor)
          )
        ),
        Expanded(child:MarkdownViewer(widget.terms)),
        Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 15, right:15), child:
        isAccepted
                ? Button(
                    "Opt Out",
                    _change,
                  )
                : Button.solid("Opt In", _change))
      ]))));

  Future<void> _change() async {
    if(!isAccepted) {
      await license(TikiSdk.instance.offers.values.first);
    }else{
      Offer oldOffer = TikiSdk.instance.offers.values.first;
      Offer offer = Offer()
          .ptr(oldOffer.getPtr)
          .terms(oldOffer.getTerms);
      await license(offer);
    }
    setState((){
      isAccepted = !isAccepted;
    });

  }

  Future<void> license(Offer offer) async {
    LicenseRecord license = await TikiSdk.license(offer.getPtr, offer.getUses, offer.getTerms);
    if(isAccepted && TikiSdk.instance.getOnAccept != null) TikiSdk.instance.getOnAccept!(offer, license);
    if(!isAccepted && TikiSdk.instance.getOnDecline != null) TikiSdk.instance.getOnDecline!(offer, license);
  }
}
