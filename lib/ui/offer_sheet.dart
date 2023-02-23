/// {@category UI}
import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/ui/completion_sheet.dart';
import 'package:tiki_sdk_flutter/ui/offer_bullets.dart';
import 'package:tiki_sdk_flutter/ui/offer_card.dart';
import 'package:tiki_sdk_flutter/ui/text_viewer.dart';

import 'assets/icons/tiki_sdk_icons_icons.dart';
import 'button.dart';
import 'offer.dart';

/// A dismissible bottom sheet that shows an [Offer] to the user.
///
/// This bottom sheet is the first UI in the TIKI user flow.
/// There are 4 available actions in this screen:
///  - learnMore: will show the [TextViewer] screen with [learnMoreText] loaded.
///  - deny: will show the [CompletionSheet.backoff].
///  - allow: will show the [CompletionSheet.awesome]. If [requireTerms] is
///  true, it will show the [TextViewer] with [termsText] for the user accept the
///  terms before the [CompletionSheet.awesome] screen is shown.
class OfferSheet extends StatelessWidget {
  final Offer offer;
  final bool requireTerms;
  final String? termsText;
  final String? learnMoreText;
  final String titleVerb;
  final Color primaryColor;
  final Color accentColor;
  final Color backgroundColor;

  const OfferSheet(this.offer,
      {super.key,
      this.requireTerms = false,
      this.termsText,
      this.learnMoreText = "",
      this.titleVerb = "TRADE",
      this.primaryColor = const Color.fromRGBO(28, 0, 0, 1),
      this.accentColor = const Color.fromRGBO(0, 178, 114, 1),
      this.backgroundColor = const Color.fromRGBO(246, 246, 246, 1)});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: RichText(
                            text: TextSpan(
                                text: titleVerb,
                                style: TextStyle(
                                    fontFamily: "SpaceGrotesk",
                                    package: "tiki_sdk_flutter",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor),
                                children: [
                              TextSpan(
                                  text: " YOUR ",
                                  style: TextStyle(color: accentColor)),
                              TextSpan(
                                  text: "DATA",
                                  style: TextStyle(color: primaryColor)),
                            ]))),
                    IconButton(
                        onPressed: () => print("learnmore"),
                        icon: Icon(TikiSdkIcons.icon_circle_question, color: Color.fromARGB(153, 0, 0, 0))),
                  ])),
          OfferCard(offer: offer),
          OfferBullets(offer, primaryColor),
          Padding(padding: EdgeInsets.only(bottom: 50, left: 15, right: 15), child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Button(
                "Back off",
                () => print("no"),
                primaryColor,
                accentColor
              ),
              Button.solid(
                "I'm in",
                () => print("ok"),
                accentColor
              )
            ])
          )
        ],
      ),
    );
  }
}
