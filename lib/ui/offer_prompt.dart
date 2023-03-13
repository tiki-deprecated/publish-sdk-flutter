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
  const OfferPrompt(this.offers,
      {super.key,
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
        color: primaryBackgroundColor ??
            TikiSdk.instance.activeTheme.primaryBackgroundColor,
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
                    LearnMoreButton(
                        iconColor: secondaryTextColor ??
                            TikiSdk.instance.activeTheme.secondaryTextColor)
                  ])),
          OfferCard(
            offers.values.toList()[0],
            textColor: primaryTextColor ??
                TikiSdk.instance.activeTheme.primaryTextColor,
            backgroundColor: primaryBackgroundColor ??
                TikiSdk.instance.activeTheme.primaryBackgroundColor,
            fontFamily: fontFamily ?? TikiSdk.instance.activeTheme.fontFamily,
            fontPackage:
                fontPackage ?? TikiSdk.instance.activeTheme.fontPackage,
          ),
          UsedFor(offers.values.toList()[0].usedBullet,
              textColor: primaryTextColor ??
                  TikiSdk.instance.activeTheme.primaryTextColor,
              fontFamily: fontFamily ?? TikiSdk.instance.activeTheme.fontFamily,
              fontPackage:
                  fontPackage ?? TikiSdk.instance.activeTheme.fontPackage),
          Padding(
              padding: const EdgeInsets.only(bottom: 50, left: 15, right: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Button("Back Off",
                        () => _decline(context, offers.values.toList()[0]),
                        textColor: primaryTextColor ??
                            TikiSdk.instance.activeTheme.primaryTextColor,
                        borderColor: accentColor ??
                            TikiSdk.instance.activeTheme.accentColor,
                        fontFamily: fontFamily ??
                            TikiSdk.instance.activeTheme.fontFamily,
                        fontPackage: fontPackage ??
                            TikiSdk.instance.activeTheme.fontPackage),
                    Button.solid(
                      "I'm in",
                      () => _accept(context, offers.values.toList()[0]),
                      color: accentColor ??
                          TikiSdk.instance.activeTheme.accentColor,
                      fontFamily:
                          fontFamily ?? TikiSdk.instance.activeTheme.fontFamily,
                      fontPackage: fontPackage ??
                          TikiSdk.instance.activeTheme.fontPackage,
                    )
                  ]))
        ],
      ),
    );
  }

  _decline(BuildContext context, Offer offer) {}

  _accept(BuildContext context, Offer offer) {}
}
