import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:tiki_sdk_flutter/ui/learn_more_btn.dart';
import 'package:tiki_sdk_flutter/ui/offer.dart';

import 'button.dart';
import 'used_bullet.dart';

class Settings extends StatefulWidget {

  final bool isIn;

  final Offer offer;
  final Markdown terms;

  final String? fontFamily;
  final String? fontPackage;

  final RichText title;

  final Color? primaryTextColor;
  final Color? secondaryTextColor;
  final Color? accentColor;

  const Settings(this.isAccepted,
      {super.key,
      required this.offerImage,
      required this.offerDescription,
      required this.title,
      required this.offerItems,
      required this.mdText,
      this.headerTextBeforeAccent,
      this.headerTextAccent,
      this.headerTextAfterAccent,
      this.package,
      this.textColor,
      this.accentColor,
      this.secondaryTextColor,
      this.fontFamily});

  @override
  State<StatefulWidget> createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  bool isAccepted = false;

  @override
  void initState() {
    isAccepted = widget.isAccepted;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop()),
        title: RichText(
            text: TextSpan(
                text: widget.headerTextBeforeAccent,
                style: TextStyle(
                    fontFamily: widget.fontFamily,
                    package: widget.fontPackage,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: widget.textColor),
                children: [
              TextSpan(
                  text: " ${widget.headerTextAccent} ",
                  style: TextStyle(color: widget.accentColor)),
              TextSpan(
                  text: widget.headerTextAfterAccent,
                  style: TextStyle(color: widget.textColor)),
            ])),
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
          child: offer),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(Terms and Conditions),
                FutureBuilder(
                    future: DefaultAssetBundle.of(context)
                        .loadString(widget.mdText),
                    builder: (context, snapshot) {
                      return Markdown(data: snapshot.data!);
                    }),
              ],
            )),
        Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: isAccepted
                ? Button(
                    "Opt Out",
                    _change,
                    widget.textColor,
                    widget.accentColor,
                    fontFamily: widget.fontFamily,
                    package: widget.fontPackage,
                  )
                : Button.solid("Opt In", _change, widget.accentColor,
                    fontFamily: widget.fontFamily, package: widget.fontPackage))
      ])));

  Future<void> _change() async {
    setState(() {
      isAccepted = !isAccepted;
    });
  }
}
