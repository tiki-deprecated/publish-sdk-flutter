/// {@category UI}
import 'package:flutter/material.dart';

import 'button.dart';
import 'learn_more_btn.dart';
import 'reward_card.dart';
import 'used_bullet.dart';
import 'used_for.dart';

class DecisionSheet extends StatelessWidget {

  final RichText title;

  final Image reward;
  final String description;
  final List<UsedBullet> usedFor;

  final Function backOff;
  final Function imIn;

  final Color? primaryTextColor;
  final Color? secondaryTextColor;
  final Color? primaryBackgroundColor;
  final Color? secondaryBackgroundColor;
  final Color? accentColor;

  final String? fontFamily;
  final String? fontPackage;


  const DecisionSheet(this.title, this.description, this.reward, this.usedFor,
    this.backOff, this.imIn, {
    super.key,
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
          RewardCard(
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
                    Button("Back Off", () => backOff, primaryTextColor,
                        accentColor,
                        fontFamily: fontFamily, package: fontPackage),
                    Button.solid(
                      "I'm in", () => imIn, accentColor, fontFamily: fontFamily,
                      package: fontPackage,
                    )
                  ]))
        ],
      ),
    );
  }
}
