/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
/// {@category UI}
import 'package:flutter/material.dart';

import '../offer.dart';
import '../tiki_sdk.dart';

/// A card that represents an [Offer] to the user.
class OfferCard extends StatelessWidget {

  /// The offer to be shown.
  final Offer offer;

  late final Color? textColor;
  late final Color? backgroundColor;

  late final String? fontFamily;
  late final String? fontPackage;

  OfferCard(this.offer,
      {super.key,
      textColor,
      backgroundColor,
      fontFamily,
      fontPackage}){
    this.textColor = textColor ?? TikiSdk.theme.primaryTextColor;
    this.backgroundColor = backgroundColor ?? TikiSdk.theme.primaryBackgroundColor;
    this.fontFamily = fontFamily ?? TikiSdk.theme.fontFamily;
    this.fontPackage = fontPackage ?? TikiSdk.theme.fontPackage;
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: backgroundColor,
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
                      child: SizedBox(width: 300, height: 86, child: offer.reward),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: RichText(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: offer.description,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  height: 1.2,
                                  color: textColor,
                                  fontFamily: fontFamily,
                                  package: fontPackage))),
                    )
                  ],
                ))),
      );
}
