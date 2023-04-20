/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// {@category UI}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../src/assets/icons/tiki_sdk_icons_icons.dart';
import '../../tiki_sdk.dart';
import 'learn_more.dart';

class LearnMoreButton extends StatelessWidget {
  late final Color iconColor;
  late final Color textColor;
  late final Color backgroundColor;
  late final String? fontFamily;
  late final String? fontPackage;

  LearnMoreButton({super.key})
      : iconColor = TikiSdk.instance.activeTheme.getSecondaryTextColor,
        textColor = TikiSdk.instance.activeTheme.getPrimaryTextColor,
        backgroundColor =
            TikiSdk.instance.activeTheme.getPrimaryBackgroundColor,
        fontFamily = TikiSdk.instance.activeTheme.getFontFamily,
        fontPackage = TikiSdk.instance.activeTheme.getFontPackage;

  @override
  Widget build(BuildContext context) => IconButton(
      onPressed: null,
      icon: IconButton(
          icon: Icon(TikiSdkIcons.circleQuestion, color: iconColor),
          onPressed: () async {
            String txt = await rootBundle.loadString(
                "packages/tiki_sdk_flutter/lib/src/assets/data/learn_more.md");
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LearnMore(txt)));
          }));
}
