/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// {@category UI}
import 'package:flutter/cupertino.dart';
import 'package:tiki_sdk_dart/license_record.dart';

import '../../tiki_sdk.dart';
import '../../ui/offer.dart';

/// A dismissible bottom sheet that will be shown after the TIKI flow is complete.
class CompletionSheet extends StatelessWidget {
  /// A [RichText] title to be shown in he top of the bottom sheet.
  final RichText title;

  /// The center message of the ending screen.
  final String message;

  /// The sub text shown below the message.
  final RichText footnote;

  late final Color primaryTextColor;
  late final Color backgroundColor;
  late final String fontFamily;
  late final String fontPackage;

  /// Completion Sheet Builder
  ///
  /// [TikiSdk.theme] is used for default styling.
  CompletionSheet(this.title, this.message, this.footnote,
      {super.key, fontFamily, fontPackage, primaryTextColor, backgroundColor}) {
    this.primaryTextColor = TikiSdk.instance.activeTheme.getPrimaryTextColor;
    this.backgroundColor = TikiSdk.instance.activeTheme.getPrimaryBackgroundColor;
    this.fontFamily = TikiSdk.instance.activeTheme.getFontFamily;
    this.fontPackage = TikiSdk.instance.activeTheme.getFontPackage;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(top: 28.0), child: title),
              Padding(
                  padding: const EdgeInsets.only(top: 36.0),
                  child: Text(message,
                      style: TextStyle(
                          fontFamily: fontFamily,
                          package: fontPackage,
                          fontSize: 32,
                          height: 1.3125,
                          fontWeight: FontWeight.bold,
                          color: primaryTextColor))),
              Padding(
                  padding: const EdgeInsets.only(top: 36.0), child: footnote),
            ]));
  }

  /// Creates a new License, based on the the user choice about the [offer].
  ///
  /// If the user [accepted] the [offer], the License will include the [Offer.uses].
  /// If not the License will have no uses.
  /// Creates a new Title record or retrieves an existing one before creating
  /// the License.
  static Future<LicenseRecord> license(Offer offer, bool accepted) async {
    return await TikiSdk.license(offer.getPtr, offer.getUses, offer.getTerms);
  }
}
