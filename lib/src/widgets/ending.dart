/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// {@category UI}
import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:tiki_sdk_flutter/src/widgets/your_choice.dart';

import '../../tiki_sdk.dart';
import 'whoops.dart';

class Ending extends StatelessWidget {

  late final Widget title;
  late final String message;
  late final Widget footnote;
  late final Color primaryTextColor;
  late final Color secondaryTextColor;
  late final Color backgroundColor;
  late final String fontFamily;
  late final String fontPackage;

  Ending(this.title, this.message, this.footnote,
      {super.key, fontFamily, fontPackage, primaryTextColor, backgroundColor}) {
    this.primaryTextColor = primaryTextColor ?? TikiSdk.instance.activeTheme.getPrimaryTextColor;
    this.backgroundColor = backgroundColor ??
        TikiSdk.instance.activeTheme.getPrimaryBackgroundColor;
    this.fontFamily = fontFamily ?? TikiSdk.instance.activeTheme.getFontFamily;
    this.fontPackage = fontPackage ?? TikiSdk.instance.activeTheme.getFontPackage;
  }

  Ending.accepted(BuildContext context, {
    Color? primaryTextColor,
    Color? secondaryTextColor,
    Color? backgroundColor,
    String? fontFamily,
    String? fontPackage,
  }) : this.title = YourChoice(),
       this.message = "Awesome! You’re in" {
    this.primaryTextColor = primaryTextColor ??
    TikiSdk.instance.activeTheme.getPrimaryTextColor;
    this.secondaryTextColor = secondaryTextColor ??
        TikiSdk.instance.activeTheme.getSecondaryTextColor;
    this.backgroundColor = backgroundColor ??
    TikiSdk.instance.activeTheme.getPrimaryBackgroundColor;
    this.fontFamily = fontFamily ?? TikiSdk.instance.activeTheme.getFontFamily;
    this.fontPackage = fontPackage ?? TikiSdk.instance.activeTheme.getFontPackage;
    this.footnote = _acceptedFootnote(context, this.primaryTextColor, this.backgroundColor, this.fontFamily, this.fontPackage);
  }
  Ending.declined(BuildContext context, {
    Color? primaryTextColor,
    Color? secondaryTextColor,
    Color? backgroundColor,
    String? fontFamily,
    String? fontPackage,
  }){
    this.title = YourChoice();
    this.message = "Backing Off";
    this.primaryTextColor = primaryTextColor ??
        TikiSdk.instance.activeTheme.getPrimaryTextColor;
    this.secondaryTextColor = primaryTextColor ??
        TikiSdk.instance.activeTheme.getSecondaryTextColor;
    this.backgroundColor = backgroundColor ??
        TikiSdk.instance.activeTheme.getPrimaryBackgroundColor;
    this.fontFamily = fontFamily ?? TikiSdk.instance.activeTheme.getFontFamily;
    this.fontPackage =
        fontPackage ?? TikiSdk.instance.activeTheme.getFontPackage;
    this.footnote = _declinedFootnote(context, this.secondaryTextColor, this.fontFamily, this.fontPackage);
  }

  Ending.error(String permissionName, {
    Color? primaryTextColor,
    Color? secondaryTextColor,
    Color? backgroundColor,
    String? fontFamily,
    String? fontPackage,
  }){
    this.title = Whoops();
    this.message = "Permission Required";
    this.primaryTextColor = primaryTextColor ??
      TikiSdk.instance.activeTheme.getPrimaryTextColor;
    this.secondaryTextColor = primaryTextColor ??
        TikiSdk.instance.activeTheme.getSecondaryTextColor;
    this.backgroundColor = backgroundColor ??
      TikiSdk.instance.activeTheme.getPrimaryBackgroundColor;
    this.fontFamily = fontFamily ?? TikiSdk.instance.activeTheme.getFontFamily;
    this.fontPackage = fontPackage ?? TikiSdk.instance.activeTheme.
    getFontPackage;
    this.footnote = _errorFootnote(permissionName, this.secondaryTextColor, this.fontFamily, this.fontPackage);
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(top: 28.0)),
              title,
              Padding(
                  padding: const EdgeInsets.only(top: 36.0),
              ),
              Text(message,
                      style: TextStyle(
                          fontFamily: fontFamily,
                          package: fontPackage,
                          fontSize: 32,
                          height: 1.3125,
                          fontWeight: FontWeight.w500,
                          color: primaryTextColor)),
              Padding(
                  padding: const EdgeInsets.only(top: 36.0)),
              footnote,
              Padding(
                  padding: const EdgeInsets.only(bottom: 50.0)),
            ]));
  }

  static Widget _acceptedFootnote(BuildContext context,
      Color primaryTextColor,
      Color backgroundColor,
      String fontFamily,
      String fontPackage) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("We’re on it, stay tuned",  style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: TikiSdk
                  .instance.activeTheme.getSecondaryTextColor,
              fontFamily: TikiSdk.instance.activeTheme.getFontFamily,
              package: TikiSdk.instance.activeTheme.getFontPackage)),
          Padding(padding: EdgeInsets.only(top:6)),
          RichText(
              text: TextSpan(
                  text: "Change your mind anytime in ",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: TikiSdk
                          .instance.activeTheme.getSecondaryTextColor,
                      fontFamily: TikiSdk.instance.activeTheme.getFontFamily,
                      package: TikiSdk.instance.activeTheme.getFontPackage),
                  children: [
                TextSpan(
                    text: "settings",
                    style: TextStyle(decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                      Navigator.of(context).pop();
                      TikiSdk.instance.getOnSettings(context);
                    }
                ),
                TextSpan(text: ".")
              ]))
        ]);
  }

  static Widget _declinedFootnote(BuildContext context, Color secondaryTextColor,
      String fontFamily,
      String fontPackage) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Your data is valuable.", style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w300,
        color: secondaryTextColor,
        fontFamily: fontFamily,
        package: fontPackage)),
          Padding(padding: EdgeInsets.only(top:6)),
          RichText(
              text: TextSpan(
                  text: "Opt-in anytime in ",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: secondaryTextColor,
                      fontFamily: fontFamily,
                      package: fontPackage),
                  children: [
                TextSpan(
                    text: "settings",
                    style: TextStyle(decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                      Navigator.of(context).pop();
                      TikiSdk.instance.getOnSettings(context);
                    }),
                TextSpan(text: ".")
              ]))
        ]);
  }

  static Widget _errorFootnote(
      String permissionName,
      Color secondaryTextColor,
      String fontFamily,
      String fontPackage) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Offer declined.", style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: secondaryTextColor,
              fontFamily: fontFamily,
              package: fontPackage),),
          Padding(padding: EdgeInsets.only(top:6)),
          RichText(
              text: TextSpan(
                  text: "To proceed, allow ",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: secondaryTextColor,
                      fontFamily: fontFamily,
                      package: fontPackage),
                  children: [
                TextSpan(
                    text: permissionName,
                    style: TextStyle(decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => AppSettings.openAppSettings()),
                TextSpan(text: ".")
              ]))
        ]);
  }
}
