/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// {@category UI}
import 'package:flutter/material.dart';

import '../../tiki_sdk.dart';
import '../../ui/offer.dart';

class OfferCard extends StatelessWidget {
  final Offer offer;
  late final Color primaryBackgroundColor;
  late final Color secondaryTextColor;
  late final String fontFamily;
  late final String fontPackage;

  OfferCard(this.offer, {super.key,
    Color? primaryBackgroundColor,
    Color? secondaryTextColor,
    String? fontFamily,
    String? fontPackage}){
    this.primaryBackgroundColor = primaryBackgroundColor ?? TikiSdk.instance.activeTheme.getPrimaryBackgroundColor;
    this.secondaryTextColor = secondaryTextColor ?? TikiSdk.instance.activeTheme.getSecondaryTextColor;
    this.fontFamily = fontFamily ?? TikiSdk.instance.activeTheme.getFontFamily;
    this.fontPackage = fontPackage ?? TikiSdk.instance.activeTheme.getFontPackage;
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: primaryBackgroundColor,
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(13, 0, 0, 0), offset: Offset(4, 4))
                ],
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SizedBox(
                          width: 300, height: 86, child: offer.getReward),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: RichText(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: offer.getDescription,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  height: 1.2,
                                  color: secondaryTextColor,
                                  fontFamily: fontFamily,
                                  package: fontPackage))),
                    )
                  ],
                ))),
      );
}
