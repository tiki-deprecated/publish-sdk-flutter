/// {@category UI}
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';

/// A dismissible bottom sheet that will be shown after the TIKI flow is complete.
class CompletionSheet extends StatelessWidget {
  /// The color that will be used in "your".
  final Color? accentColor;

  /// The text color.
  final Color? textColor;

  /// The color used in all backgrounds.
  final Color? backgroundColor;

  /// The main text in the center of the bottom sheet.
  final String title;

  /// The first line of text in the footer.
  ///
  /// This text will occupy just one line. An ellipsis will be added on overflow.
  final String footerText;

  /// The text to be shown before the "settings" link.
  final String beforeLinkText;

  /// The fontFamily from pubspec.
  final String? fontFamily;

  /// The package.
  final String? package;

  final String linkText;

  final Function? onTap;

  final Color? secondaryTextColor;

  final String headerTextBeforeAccent;
  final String headerTextAccent;
  final String headerTextAfterAccent;

  /// Default constructor for Completion Bottom Sheet
  ///
  /// The CompletionSheet is fully customizable using this constructor
  ///
  /// Parameters:
  /// - title: the main text in the center of the bottom sheet
  /// - footerText: the first line of text in the footer. One line of text.
  /// - beforeLinkText: the text to be shown before the "settings" link.
  /// - accentColor: The color that will be used in "your". Default #24956A
  /// - textColor: The text color. Default #2D2D2D
  /// - backgroundColor: default #FFFFFF
  /// - font: the fontFamily from pubspec. Default "SpaceGrotesk"
  const CompletionSheet(this.title,
      this.footerText,
      this.linkText,
      this.beforeLinkText, {super.key,
        this.headerTextBeforeAccent = "",
        this.headerTextAccent = "",
        this.headerTextAfterAccent = "",
        this.accentColor,
        this.textColor,
        this.secondaryTextColor,
        this.backgroundColor,
        this.onTap,
        this.fontFamily,
        this.package
      });

  /// The CompletionSheet to be shown after user denies the use of data.
  ///
  /// Parameters:
  /// - accentColor: The color that will be used in "your". Default #24956A
  /// - textColor: The text color. Default #2D2D2D
  /// - backgroundColor: default #FFFFFF
  /// - font: the fontFamily from pubspec. Default "SpaceGrotesk"
  const CompletionSheet.backoff(
      {super.key,
      this.accentColor,
      this.textColor,
      this.secondaryTextColor,
      this.backgroundColor,
      this.fontFamily,
      this.package})
      : title = "Backing Off",
        footerText = "Your data is valuable.",
        linkText = "settings",
        beforeLinkText = "Opt-in anytime in ",
        headerTextBeforeAccent = "",
        headerTextAccent = "YOUR",
        headerTextAfterAccent = "CHOICE",
        onTap = _goToSettings;

  /// The CompletionSheet to be shown after user allows the use of data.
  ///
  /// Parameters:
  /// - accentColor: The color that will be used in "your". Default #24956A
  /// - textColor: The text color. Default #2D2D2D
  /// - backgroundColor: default #FFFFFF
  /// - font: the fontFamily from pubspec. Default "SpaceGrotesk"
  const CompletionSheet.awesome(
      {super.key,
        this.textColor,
        this.secondaryTextColor,
        this.accentColor,
        this.backgroundColor,
        this.fontFamily,
        this.package})
      : title = "Awesome! You’re in",
        footerText = "We’re on it, stay tuned.",
        linkText = "settings",
        beforeLinkText = "Change your mind anytime in",
        headerTextBeforeAccent = "",
        headerTextAccent = "YOUR",
        headerTextAfterAccent = "CHOICE",
        onTap = _goToSettings;

  /// The CompletionSheet to be shown if additional steps are required.
  ///
  /// Parameters:
  /// - accentColor: The color that will be used in "your". Default #24956A
  /// - textColor: The text color. Default #2D2D2D
  /// - backgroundColor: default #FFFFFF
  /// - font: the fontFamily from pubspec. Default "SpaceGrotesk"
  CompletionSheet.requestPermissions(
      Map<String, Permission> requiredPermissions,
      {super.key,
        this.headerTextBeforeAccent = "",
        this.headerTextAccent = "WHOOPS",
        this.headerTextAfterAccent = "",
        this.textColor,
        this.secondaryTextColor,
        this.accentColor,
        this.backgroundColor,
        this.fontFamily,
        this.package,
        }) : assert(requiredPermissions.isEmpty, "A least one permission should be requested"),
          title = "Permission Required",
          footerText = "Offer declined.",
          beforeLinkText = "To proceed, allow ",
          linkText = requiredPermissions.length == 1 ? requiredPermissions.keys.single : "permissions",
          onTap = _requestPermissions(requiredPermissions.values.toList());


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
                  padding: const EdgeInsets.only(top: 28.0),
                  child: RichText(
                      text: TextSpan(
                          text: headerTextBeforeAccent,
                          style:
                          TextStyle(
                              fontFamily: fontFamily,
                              package: package,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textColor)
                          ,
                          children: [
                        TextSpan(
                            text: " $headerTextAccent ",
                            style: TextStyle(color: accentColor)),
                        TextSpan(
                            text: headerTextAfterAccent,
                            style: TextStyle(color: textColor)),
                      ]))),
              Padding(
                  padding: const EdgeInsets.only(top: 36.0),
                  child: Text(title,
                      style: TextStyle(
                          fontFamily: fontFamily,
                          package: package,
                          fontSize: 32,
                          height: 1.3125,
                          fontWeight: FontWeight.bold,
                          color: textColor))),
              Padding(
                  padding: const EdgeInsets.only(top: 36.0),
                  child: Text(footerText,
                      style: TextStyle(
                          fontFamily: fontFamily,
                          package: package,
                          fontSize: 18,
                          height: 1.275,
                          fontWeight: FontWeight.w300,
                          color: secondaryTextColor))),
              Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: RichText(
                      text: TextSpan(
                          text: beforeLinkText,
                          style: TextStyle(
                              fontFamily: fontFamily,
                              package: package,
                              fontSize: 18,
                              height: 1.275,
                              fontWeight: FontWeight.w300,
                              color: secondaryTextColor),
                          children: [
                        TextSpan(
                          text: linkText,
                          style:
                              const TextStyle(decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => onTap,
                        ),
                        const TextSpan(
                            text: ".",
                            style: TextStyle(decoration: TextDecoration.none)),
                      ])))
            ]));
  }
}

_requestPermissions(List<Permission> list) {
}

void _goToSettings(){

}
