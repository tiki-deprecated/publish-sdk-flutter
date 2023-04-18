import 'package:flutter/material.dart';

import '../../tiki_sdk.dart';

class TradeYourData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "TRADE",
          style: TextStyle(
            fontFamily: TikiSdk.instance.activeTheme.getFontFamily,
            package: TikiSdk.instance.activeTheme.getFontPackage,
            fontWeight: FontWeight.bold,
            color: TikiSdk.instance.activeTheme.getPrimaryTextColor,
            fontSize: 20,
          ),
        ),
        Text(
          " YOUR ",
          style: TextStyle(
            fontSize: 20,
            fontFamily: TikiSdk.instance.activeTheme.getFontFamily,
            package: TikiSdk.instance.activeTheme.getFontPackage,
            fontWeight: FontWeight.bold,
            color: TikiSdk.instance.activeTheme.getAccentColor,
          ),
        ),
        Text(
          "DATA",
          style: TextStyle(
            fontFamily: TikiSdk.instance.activeTheme.getFontFamily,
            package: TikiSdk.instance.activeTheme.getFontPackage,
            fontWeight: FontWeight.bold,
            color: TikiSdk.instance.activeTheme.getPrimaryTextColor,
            fontSize: 20,
          ),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
    );
  }
}
