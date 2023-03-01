/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
library tiki_sdk;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tiki_sdk_dart/cache/consent/consent_model.dart';
import 'package:tiki_sdk_dart/tiki_sdk.dart' as tiki_sdk_dart;
import 'package:tiki_sdk_dart/tiki_sdk_builder.dart';
import 'package:tiki_sdk_flutter/src/flutter_key_storage.dart';
import 'package:tiki_sdk_flutter/ui/offer_prompt.dart';
import 'offer.dart';
import 'ui/tiki_sdk_theme.dart';

/// The TIKI SDK main class. Use this to add tokenized data ownership, consent, and rewards.
///
/// TikiSdk is a singleton that keeps the latest initialized instance. All the
/// parameters are kept when a new instance is created, except for the address
class TikiSdk {

  /// Callback function for an accepted offer.
  ///
  /// The onAccpet(...) event is triggered on the user's successful acceptance
  /// of the licensing offer. This happens after accepting the terms, not just
  /// on selecting "I'm In." The License Record is passed as a parameter to the
  /// callback function.
  static Function(Offer)? onAccept;

  /// Callback function for a declined offer
  ///
  /// he onDecline() event is triggered when the user declines the licensing offer.
  /// This happens on dismissal of the flow or when "Back Off" is selected.
  static Function(Offer)? onDecline;

  /// Callback function for user selecting the "settings" option in ending widget.
  ///
  /// The onSettings() event is triggered when the user selects "settings" in the
  /// ending screen. If a callback function is not registered, the SDK defaults to
  /// calling the TikiSdk.settings() method.
  static Function(Offer)? onSettings;

  /// TikiSdkDart instance.
  final tiki_sdk_dart.TikiSdk? core;

  /// The list of possible [Offer] for the user.
  static final List<Offer> offers = [];


  static TikiSdk? _instance;
  static bool _disableAcceptEnding = false;
  static bool _disableDeclineEnding = false;
  static TikiSdkTheme _lightTheme = TikiSdkTheme.light();
  static TikiSdkTheme _darkTheme = TikiSdkTheme.dark();

  TikiSdk._(this.core);

  /// The current [TikiSdkTheme] that will be used in the prebuilt UIs.
  static TikiSdkTheme get theme{
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark ? _darkTheme : _lightTheme;
  }

  /// The wallet address that is in use.
  String? get address => core?.address;

  /// The TikiSdk singleton instance.
  static TikiSdk get instance {
    if(_instance == null){
      throw StateError("TikiSdk was not initialized.");
    }
    return _instance!;
  }

  /// Initializes the TikiSdk.
  ///
  /// The [publishingId] is used to connect to TIKI L0 Storage.
  /// A new blockchain address will be defined if no [address] provided.
  /// Identification of the [origin] is done automatically through the app's
  /// package name, and can be overriden in this method.
  static init(String publishingId, {
    String? address,
    String? origin,
    String? databaseDir
  }) async {
    WidgetsFlutterBinding.ensureInitialized();
    TikiSdkBuilder sdkBuilder = TikiSdkBuilder()
      ..databaseDir(await _dbDir())
      ..keyStorage(FlutterKeyStorage())
      ..address(address)
      ..publishingId(publishingId)
      ..origin(origin ??  (await PackageInfo.fromPlatform()).packageName);
    tiki_sdk_dart.TikiSdk tikiSdkDart = await sdkBuilder.build();
    _instance = TikiSdk._(tikiSdkDart);
    return _instance;
  }

  /// Creates a new License, based on the the user choice about the [offer].
  ///
  /// If the user [accepted] the [offer], the License will include the [Offer.uses].
  /// If not the License will have no uses.
  /// Creates a new Title record or retrieves an existing one before creating
  /// the License.
  static Future<ConsentModel> license(Offer offer, bool accepted) async {
    throw UnimplementedError();
  }

  /// Verifies if there is an active License for the [uses] of the Title
  /// identified by [ptr].
  ///
  /// Optional [onSuccess] and [onDenied] callbacks can be defined.
  static Future<bool> guard(String ptr, List<String> uses, onSuccess, onDenied) async {
    throw UnimplementedError();
  }

  /// Shows the UI Offer flow
  static Future<void> present(BuildContext context) async {
    TikiSdk tikiSdk = instance;
    showModalBottomSheet<dynamic>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) => OfferPrompt(offers));
  }

  /// Shows the Settings UI
  static Future<void> settings(BuildContext context) async {
    TikiSdk tikiSdk = instance;
  }

  /// Adds a new [Offer] for the user;
  static void addOffer(Offer offer) {
    offers.add(offer);
  }

  /// Sets the [theme] as the default light theme, overriding the current one.
  static setLightTheme(TikiSdkTheme theme) => _lightTheme = theme;

  /// Sets the [theme] as the default dark theme, overriding the current one.
  static setDarkTheme(TikiSdkTheme theme) => _darkTheme = theme;

  /// Sets the [primaryTextColor] of the current active [theme]
  static TikiSdkTheme setPrimaryTextColor(Color primaryTextColor){
    theme.setPrimaryTextColor(primaryTextColor);
    return theme;
  }

  /// Sets the [primaryBackgroundColor] of the current active [theme]
  static TikiSdkTheme setPrimaryBackgroundColor(Color primaryBackgroundColor){
    theme.setPrimaryBackgroundColor(primaryBackgroundColor);
    return theme;
  }

  /// Sets the [secondaryBackgroundColor] of the current active [theme]
  static TikiSdkTheme setSecondaryBackgroundColor(Color secondaryBackgroundColor){
    theme.setSecondaryBackgroundColor(secondaryBackgroundColor);
    return theme;
  }

  /// Sets the [fontFamily] of the current active [theme]
  static TikiSdkTheme setFontFamily(String fontFamily){
    theme.setFontFamily(fontFamily);
    return theme;
  }

  /// Sets the [fontPackage] of the current active [theme]
  static TikiSdkTheme setFontPackage(String fontPackage){
    theme.setFontPackage(fontPackage);
    return theme;
  }

  /// Disables the ending screen for accepted [Offer]
  static disableAcceptEnding(bool disable) => _disableAcceptEnding = disable;

  /// Disables the ending screen for decline [Offer]
  static disableDeclineEnding(bool disable) => _disableDeclineEnding = disable;

  static Future<String> _dbDir() async {
    final dir = await getApplicationDocumentsDirectory();
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir.path;
  }

}