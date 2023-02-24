/// {@category UI}
import 'package:flutter/cupertino.dart';

/// A dismissible bottom sheet that will be shown after the TIKI flow is complete.
class CompletionSheet extends StatelessWidget {
  final String title;
  final RichText subtitle;

  final Color? accentColor;
  final Color? primaryTextColor;
  final Color? secondaryTextColor;
  final Color? backgroundColor;

  final RichText? header;
  final String? fontFamily;
  final String? fontPackage;

  const CompletionSheet(
      this.title, this.subtitle,
      {super.key,
      this.header,
      this.primaryTextColor,
      this.accentColor,
      this.secondaryTextColor,
      this.backgroundColor,
      this.fontFamily,
      this.fontPackage});

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
                  child: header),
              Padding(
                  padding: const EdgeInsets.only(top: 36.0),
                  child: Text(title,
                      style: TextStyle(
                          fontFamily: fontFamily,
                          package: fontPackage,
                          fontSize: 32,
                          height: 1.3125,
                          fontWeight: FontWeight.bold,
                          color: primaryTextColor))),
              Padding(
                  padding: const EdgeInsets.only(top: 36.0),
                  child: subtitle),
            ]));
  }
}