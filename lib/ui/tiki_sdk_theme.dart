/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
/// {@category UI}
import 'package:flutter/painting.dart';

/// Controls the UI theming for TikiSdk.
class TikiSdkTheme{
  Color _primaryTextColor;
  Color _primaryBackgroundColor;
  Color _secondaryBackgroundColor;
  Color _accentColor;
  String _fontFamily;
  String _fontPackage;

  /// Primary text color. Used in the default text items.
  Color get primaryTextColor => _primaryTextColor;

  /// Secondary text color. Used in specific text items.
  ///
  /// Defaults to [primaryTextColor] with 60% alpha transparency.
  Color get secondaryTextColor => _primaryTextColor.withAlpha(153);

  /// Primary background color. The default color for backgrounds.
  Color get primaryBackgroundColor => _primaryBackgroundColor;

  /// Secondary background color.
  Color get secondaryBackgroundColor => _secondaryBackgroundColor;

  /// Accent color. Used to decorate or highlight items.
  Color get accentColor => _accentColor;

  /// The default font family for all texts.
  ///
  /// This should be set in the assets section of pubspec.yaml.
  String get fontFamily => _fontFamily;

  /// The package to which the font asset belongs.
  String get fontPackage => _fontPackage;

  void setPrimaryTextColor(Color primaryTextColor) =>
      _primaryTextColor = primaryTextColor;
  void setPrimaryBackgroundColor(Color primaryBackgroundColor) =>
      _primaryBackgroundColor = primaryBackgroundColor;
  void setSecondaryBackgroundColor(Color secondaryBackgroundColor) =>
      _secondaryBackgroundColor = secondaryBackgroundColor;
  void setAccentColor(Color accentColor) => _accentColor = accentColor;
  void setFontFamily(String fontFamily) => _fontFamily = fontFamily;
  void setFontPackage(String fontPackage) => _fontPackage = fontPackage;

  /// Builds a default TikiTheme.
  TikiSdkTheme() :
        _primaryTextColor = const Color(0x001C0000),
        _primaryBackgroundColor = const Color(0x001C1C1E),
        _secondaryBackgroundColor = const Color(0x00F6F6F6),
        _accentColor = const Color(0x0000B272),
        _fontFamily = "SpaceGrotesk",
        _fontPackage = "tiki_sdk_flutter";

  /// Builds the light version of the theme.
  TikiSdkTheme.light() :
    _primaryTextColor = const Color(0x001C0000),
    _primaryBackgroundColor = const Color(0x001C1C1E),
    _secondaryBackgroundColor = const Color(0x00F6F6F6),
    _accentColor = const Color(0x0000B272),
    _fontFamily = "SpaceGrotesk",
    _fontPackage = "tiki_sdk_flutter";

  /// Builds the dark version of the theme.
  TikiSdkTheme.dark() :
        _primaryTextColor = const Color(0x00F6F6F6),
        _primaryBackgroundColor = const Color(0x001C1C1E),
        _secondaryBackgroundColor = const Color(0x00F6F6F6).withOpacity(0.38),
        _accentColor = const Color(0x0000B272),
        _fontFamily = "SpaceGrotesk",
        _fontPackage = "tiki_sdk_flutter";
}