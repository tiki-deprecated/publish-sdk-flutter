/// {@category UI}
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiki_sdk_flutter/ui/completion_sheet.dart';
import 'package:tiki_sdk_flutter/ui/text_viewer.dart';

import 'assets/icons/tiki_sdk_icons_icons.dart';
import 'button.dart';
import 'learn_more_btn.dart';
import 'offer.dart';
import 'used_bullet.dart';

/// A dismissible bottom sheet that shows an [Offer] to the user.
///
/// This bottom sheet is the first UI in the TIKI user flow.
/// There are 4 available actions in this screen:
///  - learnMore: will show the [TextViewer] screen with [learnMoreText] loaded.
///  - deny: will show the [CompletionSheet.backoff].
///  - allow: will show the [CompletionSheet.awesome]. If [requireTerms] is
///  true, it will show the [TextViewer] with [termsText] for the user accept the
///  terms before the [CompletionSheet.awesome] screen is shown.
class DecisionSheet extends StatelessWidget {


  /// A description of the data usage.
  ///
  /// It will occupy 3 lines maximum in the UI. An ellipsis will be added on overflow.
  /// Accepts basic markdown styles: underline, bold and italic.
  final String description;

  /// A image description of the data usage.
  ///
  /// Use a 300x86px image. TODO add information about importing assets
  final Image image;

  /// The list of items that describes what can be done with the user data.
  ///
  /// Maximum 3 items.
  final List<UsedBullet> bullets;
  final Map<String, Permission> requiredPermissions;
  final String titleVerb;
  final Color? primaryTextColor;
  final Color? secondaryTextColor;
  final Color? primaryBackgroundColor;
  final Color? secondaryBackgroundColor;
  final Color? accentColor;
  final Color? backgroundColor;
  final String? fontFamily;
  final String? package;
  final String headerTextAccent;
  final String headerTextAfterAccent;

  bool termsAccepted = false;

  DecisionSheet(this.description,  this.image,  this.bullets,
      {super.key,
      this.requiredPermissions = const {},
      this.titleVerb = "TRADE",
      this.primaryTextColor,
      this.secondaryTextColor,
      this.primaryBackgroundColor,
      this.secondaryBackgroundColor,
      this.accentColor,
      this.backgroundColor,
      this.fontFamily,
      this.package,
        this.headerTextAccent = "YOUR",
        this.headerTextAfterAccent = "DATA",
      });

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
          Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, left: 15.0, right: 15, bottom: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: RichText(
                            text: TextSpan(
                                text: titleVerb,
                                style: fontFamily != null ?
                                  TextStyle(
                                      fontFamily: fontFamily,
                                      package: package,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: primaryTextColor) :
                                TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: primaryTextColor),
                                children: [
                              TextSpan(
                                  text: headerTextAccent,
                                  style: TextStyle(color: accentColor)),
                              TextSpan(
                                  text: headerTextAfterAccent,
                                  style: TextStyle(color: primaryTextColor)),
                            ]))),
                      LearnMoreButton(iconColor: secondaryTextColor)
                  ])),
          Offer(image, description, bullets, textColor: primaryTextColor, backGroundColor: backgroundColor, fontFamily: fontFamily, package: package,),
          Padding(
              padding: const EdgeInsets.only(bottom: 50, left: 15, right: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Button("Back Off", () {
                      Navigator.pop(context);
                      showModalBottomSheet<dynamic>(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext context) =>
                              CompletionSheet.backoff());
                    }, primaryTextColor, accentColor),
                    Button.solid("I'm in", () {
                        _handleCompletion(context);
                      }, accentColor)
                  ]))
        ],
      ),
    );
  }

  Future<void> _handleCompletion(BuildContext context) async {
    if(!termsAccepted){
      bool accepted = await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>
              TextViewer('assets/data/text.md', "Terms and Conditions",
                  textColor: primaryTextColor,
                  buttonColor: accentColor,
                  backgroundColor: backgroundColor)));
      if(accepted) {
        Navigator.pop(context);
        showModalBottomSheet<dynamic>(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) =>
                CompletionSheet.awesome());
      }
      return;
    }
    for(Permission permission in requiredPermissions.values){
      var status = await permission.status;
      if (status != PermissionStatus.granted) {
        Navigator.pop(context);
        showModalBottomSheet<dynamic>(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) =>
                CompletionSheet.requestPermissions(requiredPermissions));
        return;
      }
    }
    Navigator.pop(context);
    showModalBottomSheet<dynamic>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) =>
          CompletionSheet.awesome());

  }
}
