/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// {@category UI}
import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/src/widgets/trade_your_data.dart';

import '../../tiki_sdk.dart';
import '../../ui/offer.dart';
import 'button.dart';
import 'learn_more_btn.dart';
import 'offer_card.dart';
import 'used_for.dart';

/// A bottom sheet that will prompt user with [Offer] options.
class OfferPrompt extends StatelessWidget {

  /// Builds the [OfferPropt].
  ///
  /// [TikiSdk.theme] is used for default styling.
  const OfferPrompt();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TikiSdk.instance.activeTheme.getSecondaryBackgroundColor,
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
                      child: TradeYourData(),
                    ),
                    LearnMoreButton()
                  ])),
          OfferCard(TikiSdk.instance.offers.values.toList()[0]),
          UsedFor(TikiSdk.instance.offers.values.toList()[0].getBullets),
        //   Padding(
        //       padding: const EdgeInsets.only(bottom: 50, left: 15, right: 15),
        //       child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Button("Back Off", () => _decline(context, offers.values.toList()[0])),
        //             Button.solid(
        //               "I'm in",
        //               () => _accept(context, offers.values.toList()[0]),
        //             )
        //           ]))
        ],
      ),
    );
  }

  _decline(BuildContext context, Offer offer) {}

  _accept(BuildContext context, Offer offer) {}
}
