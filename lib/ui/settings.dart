import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/ui/learn_more_btn.dart';
import 'package:tiki_sdk_flutter/ui/offer_card.dart';

import 'button.dart';
import 'markdown.dart';
import 'used_for.dart';

class Settings extends StatefulWidget {

  final bool isIn;

  final RichText title;

  final OfferCard rewardCard;
  final UsedFor usedFor;
  final MarkdownViewer terms;

  final String? fontFamily;
  final String? fontPackage;

  final Color? primaryTextColor;
  final Color? secondaryTextColor;
  final Color? accentColor;

  const Settings(this.isIn, this.title, this.rewardCard, this.usedFor, this.terms,
      {super.key,
      this.accentColor,
      this.primaryTextColor,
      this.secondaryTextColor,
      this.fontFamily,
      this.fontPackage});

  @override
  State<StatefulWidget> createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  bool isAccepted = false;

  @override
  void initState() {
    isAccepted = widget.isIn;
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
            widget.rewardCard,
            widget.usedFor
          ]),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Terms and Conditions"),
                widget.terms
              ],
            )),
        Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: isAccepted
                ? Button(
                    "Opt Out",
                    _change,
                    widget.primaryTextColor,
                    widget.accentColor,
                    fontFamily: widget.fontFamily,
                    fontPackage: widget.fontPackage,
                  )
                : Button.solid("Opt In", _change, widget.accentColor,
                    fontFamily: widget.fontFamily, fontPackage: widget.fontPackage))
      ])));

  Future<void> _change() async {
    setState(() {
      isAccepted = !isAccepted;
    });
  }
}
