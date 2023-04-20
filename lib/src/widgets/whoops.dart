/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/material.dart';

import '../../tiki_sdk.dart';

class Whoops extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "WHOOPS",
          style: TextStyle(
            fontSize: 20,
            fontFamily: TikiSdk.instance.activeTheme.getFontFamily,
            package: TikiSdk.instance.activeTheme.getFontPackage,
            fontWeight: FontWeight.bold,
            color: const Color.fromRGBO(199, 48, 0, 1),
          ),
        ),
      ],
      mainAxisSize: MainAxisSize.max,
    );
  }
}
