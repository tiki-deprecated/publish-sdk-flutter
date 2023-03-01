/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
/// {@category UI}
import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/tiki_sdk.dart';
import 'package:tiki_sdk_flutter/ui/learn_more_btn.dart';
import 'package:tiki_sdk_flutter/ui/markdown.dart';

import '../offer.dart';
import 'button.dart';
import 'offer_card.dart';
import 'used_for.dart';

class Settings extends StatefulWidget {

  final RichText? title;

  final List<Offer> offers;

  late final Color primaryTextColor;
  late final Color secondaryTextColor;
  late final Color btnOutlineTextColor;
  late final Color btnOutlineBorderColor;
  late final Color btnSolidColor;

  late final String? fontPackage;
  late final String? fontFamily;

  Settings(this.offers, {super.key, this.title,
    Color? primaryTextColor,
    Color? secondaryTextColor,
    Color? btnOutlineTextColor,
    Color? btnOutlineBorderColor,
    Color? btnSolidColor,
    String? fontPackage,
    String? fontFamily,
  }){
    primaryTextColor = primaryTextColor ?? TikiSdk.theme.primaryTextColor;
    secondaryTextColor = secondaryTextColor ?? TikiSdk.theme.secondaryTextColor;
    btnOutlineTextColor = btnOutlineTextColor ?? TikiSdk.theme.primaryTextColor;
    btnOutlineBorderColor = btnOutlineBorderColor ?? TikiSdk.theme.accentColor;
    btnSolidColor = btnSolidColor ?? TikiSdk.theme.accentColor;
    fontPackage = fontPackage ?? TikiSdk.theme.fontPackage;
    fontFamily = fontFamily ?? TikiSdk.theme.fontFamily;
  }

  @override
  State<StatefulWidget> createState() => SettingsState();
}

class SettingsState extends State<Settings> {

  int offerIndex = 0;
  bool isAccepted = false;

  @override
  void initState() {
    TikiSdk.guard(widget.offers[offerIndex].ptr, widget.offers[offerIndex].uses,
        () => setState(() => isAccepted = true),
        () => setState(() => isAccepted = false));
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
            OfferCard(widget.offers[offerIndex]),
            UsedFor(widget.offers[offerIndex].usedBullet)
          ]),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Terms and Conditions"),
                MarkdownViewer(widget.offers[offerIndex].terms)
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
                : Button.solid("Opt In", _change, color: widget.btnSolidColor,
                    fontFamily: widget.fontFamily, fontPackage: widget.fontPackage))
      ])));

  Future<void> _change() async {
    // TODO await change license
    TikiSdk.guard(widget.offers[offerIndex].ptr, widget.offers[offerIndex].uses,
            () => setState(() => isAccepted = true),
            () => setState(() => isAccepted = false));
  }
}
