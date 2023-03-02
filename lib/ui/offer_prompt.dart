/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
/// {@category UI}
import 'package:flutter/material.dart';

import '../offer.dart';
import '../tiki_sdk.dart';
import 'button.dart';
import 'learn_more_btn.dart';
import 'offer_card.dart';
import 'used_for.dart';

/// A bottom sheet that will prompt user with [Offer] options.
class OfferPrompt extends StatelessWidget {

  /// The map [Offer.id] and [Offer] to be displayed as options for the client.
  final Map<String, Offer> offers;

  /// A title that will be displayed in the top of the list.
  final RichText? title;

  final Color? primaryBackgroundColor;
  final Color? secondaryTextColor;
  final Color? primaryTextColor;
  final String? fontFamily;
  final String? fontPackage;
  final Color? accentColor;

  /// Builds the [OfferPropt].
  ///
  /// [TikiSdk.theme] is used for default styling.
  const OfferPrompt(this.offers, {super.key,
    this.title,
    this.primaryBackgroundColor,
    this.secondaryTextColor,
    this.primaryTextColor,
    this.fontFamily,
    this.fontPackage,
    this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primaryBackgroundColor ?? TikiSdk.theme.primaryBackgroundColor,
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
                    LearnMoreButton(iconColor: secondaryTextColor ?? TikiSdk.theme.secondaryTextColor)
                  ])),
          OfferCard(offers.values.toList()[0],
            textColor: primaryTextColor ?? TikiSdk.theme.primaryTextColor,
            backgroundColor: primaryBackgroundColor ?? TikiSdk.theme.primaryBackgroundColor,
            fontFamily: fontFamily ?? TikiSdk.theme.fontFamily,
            fontPackage: fontPackage ?? TikiSdk.theme.fontPackage,
          ),
          UsedFor(offers.values.toList()[0].usedBullet,
              textColor: primaryTextColor ?? TikiSdk.theme.primaryTextColor,
              fontFamily: fontFamily ?? TikiSdk.theme.fontFamily,
              fontPackage: fontPackage ?? TikiSdk.theme.fontPackage),
          Padding(
              padding: const EdgeInsets.only(bottom: 50, left: 15, right: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Button("Back Off", () => _decline(context, offers.values.toList()[0]),
                        textColor: primaryTextColor ?? TikiSdk.theme.primaryTextColor,
                        borderColor: accentColor ?? TikiSdk.theme.accentColor,
                        fontFamily: fontFamily ?? TikiSdk.theme.fontFamily,
                        fontPackage: fontPackage ?? TikiSdk.theme.fontPackage),
                    Button.solid(
                      "I'm in", () => _accept(context, offers.values.toList()[0]), color: accentColor ?? TikiSdk.theme.accentColor, fontFamily: fontFamily ?? TikiSdk.theme.fontFamily,
                      fontPackage: fontPackage ?? TikiSdk.theme.fontPackage,
                    )
                  ]))
        ],
      ),
    );
  }

  _decline(BuildContext context, Offer offer) {}

  _accept(BuildContext context, Offer offer) {}

}
