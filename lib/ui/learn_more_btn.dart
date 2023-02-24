import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'assets/icons/tiki_sdk_icons_icons.dart';
import 'text_viewer.dart';

class LearnMoreButton extends StatelessWidget{

  final Color? iconColor;

  const LearnMoreButton({super.key, this.iconColor});

  @override
  Widget build(BuildContext context) =>
    IconButton(
        onPressed: null,
        icon: IconButton(icon: Icon(TikiSdkIcons.icon_circle_question,
        color: iconColor), onPressed: () => Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => TextViewer('assets/data/text.md', "Learn More")))));

}