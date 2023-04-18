/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// {@category UI}
import 'package:flutter/painting.dart';

import '../tiki_sdk.dart';

/// Controls the UI theming for TikiSdk.
class Theme {
  Color _primaryTextColor;
  Color _primaryBackgroundColor;
  Color _secondaryBackgroundColor;
  Color _accentColor;
  String _fontFamily;
  String _fontPackage;

  /// Builds a default TikiTheme.
  Theme()
      : _primaryTextColor = const Color(0xFF1C1C1C),
        _primaryBackgroundColor = const Color(0xFFFFFFFF),
        _secondaryBackgroundColor = const Color(0xFFF6F6F6),
        _accentColor = const Color(0xFF00B277),
        _fontFamily = "SpaceGrotesk",
        _fontPackage = "tiki_sdk_flutter";

  /// Builds the light version of the theme.
  Theme.light()
      : _primaryTextColor = const Color(0xFF1C1C1C),
        _primaryBackgroundColor = const Color(0xFFFFFFFF),
        _secondaryBackgroundColor = const Color(0xFFF6F6F6),
        _accentColor = const Color(0xFF00B277),
        _fontFamily = "SpaceGrotesk",
        _fontPackage = "tiki_sdk_flutter";

  /// Builds the dark version of the theme.
  Theme.dark()
      : _primaryTextColor =  const Color(0xFFFFFFFF),
        _primaryBackgroundColor =  const Color(0xFF1C1C1C),
        _secondaryBackgroundColor = const Color(0xFF060606),
        _accentColor = const Color(0xFF00B277),
        _fontFamily = "SpaceGrotesk",
        _fontPackage = "tiki_sdk_flutter";

  /// Primary text color. Used in the default text items.
  Color get getPrimaryTextColor => _primaryTextColor;

  /// Secondary text color. Used in specific text items.
  ///
  /// Defaults to [primaryTextColor] with 60% alpha transparency.
  Color get getSecondaryTextColor => _primaryTextColor.withAlpha(153);

  /// Primary background color. The default color for backgrounds.
  Color get getPrimaryBackgroundColor => _primaryBackgroundColor;

  /// Secondary background color.
  Color get getSecondaryBackgroundColor => _secondaryBackgroundColor;

  /// Accent color. Used to decorate or highlight items.
  Color get getAccentColor => _accentColor;

  /// The default font family for all texts.
  ///
  /// This should be set in the assets section of pubspec.yaml.
  String get getFontFamily => _fontFamily;

  /// The package to which the font asset belongs.
  String get getFontPackage => _fontPackage;

  Theme primaryTextColor(Color primaryTextColor) {
    _primaryTextColor = primaryTextColor;
    return this;
  }

  Theme primaryBackgroundColor(Color primaryBackgroundColor) {
    _primaryBackgroundColor = primaryBackgroundColor;
    return this;
  }

  Theme secondaryBackgroundColor(Color secondaryBackgroundColor) {
    _secondaryBackgroundColor = secondaryBackgroundColor;
    return this;
  }

  Theme accentColor(Color accentColor) {
    _accentColor = accentColor;
    return this;
  }

  Theme fontFamily(String fontFamily) {
    _fontFamily = fontFamily;
    return this;
  }

  Theme fontPackage(String fontPackage) {
    _fontPackage = fontPackage;
    return this;
  }

  TikiSdk and() => TikiSdk.instance;
}
