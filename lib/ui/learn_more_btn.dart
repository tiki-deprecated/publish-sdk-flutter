import 'package:flutter/material.dart';

import '../src/assets/icons/tiki_sdk_icons_icons.dart';
import 'text_viewer.dart';

class LearnMoreButton extends StatelessWidget {
  final Color? iconColor;
  final Color? textColor;
  final Color? backgroundColor;
  final String? fontFamily;
  final String? package;

  const LearnMoreButton(
      {super.key,
      this.iconColor,
      this.textColor,
      this.backgroundColor,
      this.fontFamily,
      this.package});

  @override
  Widget build(BuildContext context) => IconButton(
      onPressed: null,
      icon: IconButton(
          icon: Icon(TikiSdkIcons.circleQuestion, color: iconColor),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TextViewer(
                  'assets/data/text.md', "Learn More",
                  textColor: textColor,
                  backgroundColor: backgroundColor,
                  fontFamily: fontFamily,
                  package: package)))));
}
