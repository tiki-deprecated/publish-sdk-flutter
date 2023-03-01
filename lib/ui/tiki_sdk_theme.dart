/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
/// {@category UI}
import 'package:flutter/painting.dart';

class TikiSdkTheme{
  Color _primaryTextColor;
  Color _primaryBackgroundColor;
  Color _secondaryBackgroundColor;
  Color _accentColor;
  String _fontFamily;
  String _fontPackage;

  Color get primaryTextColor => _primaryTextColor;
  Color get secondaryTextColor => _primaryTextColor.withAlpha(153);
  Color get primaryBackgroundColor => _primaryBackgroundColor;
  Color get secondaryBackgroundColor => _secondaryBackgroundColor;
  Color get accentColor => _accentColor;
  String get fontFamily => _fontFamily;
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

  TikiSdkTheme() :
        _primaryTextColor = const Color(0x001C0000),
        _primaryBackgroundColor = const Color(0x001C1C1E),
        _secondaryBackgroundColor = const Color(0x00F6F6F6),
        _accentColor = const Color(0x0000B272),
        _fontFamily = "SpaceGrotesk",
        _fontPackage = "tiki_sdk_flutter";

  TikiSdkTheme.light() :
    _primaryTextColor = const Color(0x001C0000),
    _primaryBackgroundColor = const Color(0x001C1C1E),
    _secondaryBackgroundColor = const Color(0x00F6F6F6),
    _accentColor = const Color(0x0000B272),
    _fontFamily = "SpaceGrotesk",
    _fontPackage = "tiki_sdk_flutter";

  TikiSdkTheme.dark() :
        _primaryTextColor = const Color(0x00F6F6F6),
        _primaryBackgroundColor = const Color(0x001C1C1E),
        _secondaryBackgroundColor = const Color(0x00F6F6F6).withOpacity(0.38),
        _accentColor = const Color(0x0000B272),
        _fontFamily = "SpaceGrotesk",
        _fontPackage = "tiki_sdk_flutter";
}