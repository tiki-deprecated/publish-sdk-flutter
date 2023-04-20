/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// {@category UI}
import 'package:flutter/material.dart';

import '../../tiki_sdk.dart';

class NavigationHeader {
  String title;
  AppBar appBar;

  NavigationHeader(this.title, context)
      : appBar = AppBar(
            centerTitle: false,
            leadingWidth: 30,
            elevation: 0,
            backgroundColor:
                TikiSdk.instance.activeTheme.getPrimaryBackgroundColor,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: TikiSdk.instance.activeTheme.getPrimaryTextColor,
                onPressed: () => Navigator.of(context).pop()),
            title: Text(title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: TikiSdk.instance.activeTheme.getPrimaryTextColor,
                )));
}
