/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
/// {@category UI}
import 'package:flutter/painting.dart';

import '../tiki_sdk.dart';

/// The Tiki SDK theme for pre-built UIs.
///
/// The pre-built UI styles are defined by a [Theme] object. To configure a theme,
/// chain calls to the [TikiSdk.config] method. For example:
///
/// ```
/// TikiSdk.config()
///     .theme
///         .primaryTextColor(Colors.black)
///         .primaryBackgroundColor(Colors.white)
///         .accentColor(Colors.blue)
///         .fontFamily("test")
/// ```
///
/// To configure a dark theme, use the `TikiSdk.dark` property or chain calls
/// to the `config()` method:
///
/// ```
/// TikiSdk.config()
///     .theme
///         .primaryTextColor(Colors.black)
///         .primaryBackgroundColor(Colors.white)
///         .accentColor(Colors.blue)
///         .fontFamily("test")
///     .and()
///     .dark
///         .primaryTextColor(Colors.white)
///         .primaryBackgroundColor(Colors.black)
///         .accentColor(Colors.white)
///         .fontFamily("test")
/// ```
///
/// The dark theme is only used if explicitly configured and if the OS is using a dark theme.
///
/// To configure fonts, first load the font assets files with `pubsbec.yaml` and
/// set the [fontFamily] and [fontPackage].
class Theme {
  Color _primaryTextColor;
  Color _primaryBackgroundColor;
  Color _secondaryBackgroundColor;
  Color _accentColor;
  String? _fontFamily;
  String? _fontPackage;

  /// Builds a default TikiTheme.
  Theme()
      : _primaryTextColor = const Color(0xFF1C1C1C),
        _primaryBackgroundColor = const Color(0xFFFFFFFF),
        _secondaryBackgroundColor = const Color(0xFFF6F6F6),
        _accentColor = const Color(0xFF00B277);

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
  String? get getFontFamily => _fontFamily;

  /// The package to which the font asset belongs.
  String? get getFontPackage => _fontPackage;

  /// Sets the [_primaryTextColor]
  Theme primaryTextColor(Color primaryTextColor) {
    _primaryTextColor = primaryTextColor;
    return this;
  }

  /// Sets the [_primaryBackgroundColor]
  Theme primaryBackgroundColor(Color primaryBackgroundColor) {
    _primaryBackgroundColor = primaryBackgroundColor;
    return this;
  }

  /// Sets the [_secondaryBackgroundColor]
  Theme secondaryBackgroundColor(Color secondaryBackgroundColor) {
    _secondaryBackgroundColor = secondaryBackgroundColor;
    return this;
  }

  /// Sets the [_accentColor]
  Theme accentColor(Color accentColor) {
    _accentColor = accentColor;
    return this;
  }

  /// Sets the [_fontFamily]
  Theme fontFamily(String fontFamily) {
    _fontFamily = fontFamily;
    return this;
  }

  /// Sets the [_fontPackage]
  Theme fontPackage(String fontPackage) {
    _fontPackage = fontPackage;
    return this;
  }

  /// Returns the [TikiSdk] instance to simplify the chaining of methods in
  /// SDK configuration and initialization.
  TikiSdk and() => TikiSdk.instance;
}
