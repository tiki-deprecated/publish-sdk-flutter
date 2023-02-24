/// {@category UI}
import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/ui/terms.dart';

import 'button.dart';
import 'learn_more_btn.dart';
import 'offer_card.dart';
import 'used_bullet.dart';
import 'used_for.dart';

class Offer extends StatelessWidget {

  final RichText title;

  final Image reward;
  final String description;
  final List<UsedBullet> usedFor;

  final Function onOptIn;
  final Function onOptOut;

  final Color? primaryTextColor;
  final Color? secondaryTextColor;
  final Color? primaryBackgroundColor;
  final Color? secondaryBackgroundColor;
  final Color? accentColor;

  final String? fontFamily;
  final String? fontPackage;


  const Offer(this.title, this.description, this.reward, this.usedFor,
    this.onOptOut, this.onOptIn, {super.key,
    this.primaryTextColor,
    this.secondaryTextColor,
    this.primaryBackgroundColor,
    this.secondaryBackgroundColor,
    this.accentColor,
    this.fontFamily,
    this.fontPackage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primaryBackgroundColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, left: 15.0, right: 15, bottom: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: title,
                    ),
                    LearnMoreButton(iconColor: secondaryTextColor)
                  ])),
          OfferCard(
            reward,
            description,
            textColor: primaryTextColor,
            backgroundColor: primaryBackgroundColor,
            fontFamily: fontFamily,
            fontPackage: fontPackage,
          ),
          UsedFor(usedFor,
              textColor: primaryTextColor,
              fontFamily: fontFamily,
              fontPackage: fontPackage),
          Padding(
              padding: const EdgeInsets.only(bottom: 50, left: 15, right: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Button("Back Off", () => onOptOut, primaryTextColor, accentColor,
                        fontFamily: fontFamily, fontPackage: fontPackage),
                    Button.solid(
                      "I'm in", () => _optIn(context), accentColor, fontFamily: fontFamily,
                      fontPackage: fontPackage,
                    )
                  ]))
        ],
      ),
    );
  }

  Future<void> _optIn(BuildContext context) async{
    bool termsAccepted = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) =>
            Terms("lib/src/assets/data/terms.md",
                buttonColor : accentColor,
                textColor : Colors.white,
                backgroundColor : primaryBackgroundColor,
                fontFamily : fontFamily,
                fontPackage : fontPackage)));
    if(termsAccepted){
      onOptIn();
    }
  }
}
