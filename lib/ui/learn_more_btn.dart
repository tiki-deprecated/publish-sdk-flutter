import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/ui/learn_more.dart';

import '../src/assets/icons/tiki_sdk_icons_icons.dart';

class LearnMoreButton extends StatelessWidget {
  final Color? iconColor;
  final Color? textColor;
  final Color? backgroundColor;
  final String? fontFamily;
  final String? fontPackage;

  const LearnMoreButton(
      {super.key,
      this.iconColor,
      this.textColor,
      this.backgroundColor,
      this.fontFamily,
      this.fontPackage});

  @override
  Widget build(BuildContext context) => IconButton(
      onPressed: null,
      icon: IconButton(
          icon: Icon(TikiSdkIcons.circleQuestion, color: iconColor),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LearnMore("lib/src/assets/data/terms.md",
              textColor: textColor,
              backgroundColor: backgroundColor,
              fontFamily: fontFamily,
              fontPackage: fontPackage,)))));
}
