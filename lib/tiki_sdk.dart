/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
library tiki_sdk;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:tiki_sdk_dart/cache/license/license_usecase.dart';
import 'package:tiki_sdk_dart/license_record.dart';
import 'package:tiki_sdk_dart/tiki_sdk.dart' as tiki_sdk_dart;
import 'package:tiki_sdk_flutter/src/flutter_key_storage.dart';
import 'package:tiki_sdk_flutter/ui/offer_prompt.dart';

import 'offer.dart';
import 'theme.dart' as tiki_theme;

/// The TIKI SDK main class. Use this to add tokenized data ownership, consent, and rewards.
///
/// TikiSdk is a singleton that keeps the latest initialized instance. All the
/// parameters are kept when a new instance is created, except for the address
class TikiSdk {
  static TikiSdk? _instance;

  final tiki_theme.Theme _theme = tiki_theme.Theme.light();
  tiki_theme.Theme? _dark;

  tiki_sdk_dart.TikiSdk? _core;

  Function(Offer)? _onAccept;
  Function(Offer)? _onDecline;
  Function(Offer)? _onSettings;

  bool _isAcceptEndingDisabled = false;
  bool _isDeclineEndingDisabled = false;

  final Map<String, Offer> _offers = {};

  TikiSdk._();

  /// TikiSdkDart instance. The core blockchain.
  tiki_sdk_dart.TikiSdk get core {
    if (_core == null) {
      throw StateError("Call TikiSdk.init() to initialize the TikiSdk core.");
    }
    return _core!;
  }

  /// Callback function for an accepted offer.
  Function(Offer)? get onAccept => _onAccept;

  /// Callback function for a declined offer.
  Function(Offer)? get onDecline => _onDecline;

  /// Callback function for user tapping in settings in the settings link in
  /// ending screen.
  Function(Offer)? get onSettings => _onSettings;

  /// Check if the ending screen is disabled for an accepted [Offer].
  bool get isAcceptEndingDisabled => _isAcceptEndingDisabled;

  /// Check if the ending screen is disabled for an declined [Offer].
  bool get isDeclineEndingDisabled => _isDeclineEndingDisabled;

  /// Creates a new Offer to be added in TikiSdk.
  Offer get offer => Offer();

  /// The map of possible [Offer] for the user, with its [Offer.id] as key.
  Map<String, Offer> get offers => _offers;

  /// The default light theme for TikiSdk pre-built UIs.
  tiki_theme.Theme get theme => _theme;

  /// The dark theme for TikiSdk pre-built UIs. Just used if is set in TikiSdk.
  tiki_theme.Theme get dark {
    _dark ??= tiki_theme.Theme.dark();
    return _dark!;
  }

  /// The current [tiki_theme.Theme] that will be used in the prebuilt UIs.
  tiki_theme.Theme get activeTheme {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark && _dark != null ? dark : theme;
  }

  /// The wallet address that is in use.
  String? get address => _core?.address;

  /// The current id.
  String? get id => _core?.id;

  /// The TikiSdk singleton instance.
  static TikiSdk get instance {
    _instance ??= TikiSdk._();
    return _instance!;
  }

  /// Initializes the TikiSdk.
  ///
  /// The [publishingId] is used to connect to TIKI L0 Storage.
  /// A new blockchain address will be defined if no [address] provided.
  /// Identification of the [origin] is done automatically through the app's
  /// package name, and can be overriden in this method.
  Future<TikiSdk> init(String publishingId, String id, {String? origin, String? databaseDir}) async {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterKeyStorage keyStorage = FlutterKeyStorage();
    WidgetsFlutterBinding.ensureInitialized();
    String addr =
        await tiki_sdk_dart.TikiSdk.withId(id, keyStorage);
    String dbDir = databaseDir ?? await _dbDir();
    Database database = sqlite3.open("$dbDir/$addr.db");
    _core = await tiki_sdk_dart.TikiSdk.init(
        publishingId,
        origin ?? (await PackageInfo.fromPlatform()).packageName,
        keyStorage,
        id,
        database);
    return this;
  }

  /// Creates a new License, based on the the user choice about the [offer].
  ///
  /// If the user [accepted] the [offer], the License will include the [Offer.uses].
  /// If not the License will have no uses.
  /// Creates a new Title record or retrieves an existing one before creating
  /// the License.
  static Future<LicenseRecord> license(Offer offer, bool accepted) async {
    return await instance.core.license(offer.ptr, offer.uses, offer.terms);
  }

  /// Verifies if there is an active License for the [usecases] of the Title
  /// identified by [ptr].
  ///
  /// Optional [onFail] and [onDenied] callbacks can be defined.
  static Future<bool> guard(String ptr, List<LicenseUsecase> usecases,
      {onPass, onFail}) async {
    return instance.core.guard(ptr, usecases, onFail: onFail, onPass: onPass);
  }

  /// Shows the pre built UI Offer Flow.
  static Future<void> present(BuildContext context) async {
    showModalBottomSheet<dynamic>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) => OfferPrompt(instance.offers));
  }

  /// Shows the pre built Settings UI
  static Future<void> settings(BuildContext context) async {}

  /// Starts the TikiSdk configuration.
  static TikiSdk config() {
    return instance;
  }

  /// Adds a new [Offer] for the user;
  TikiSdk addOffer(Offer offer) {
    _offers[offer.id] = offer;
    return instance;
  }

  /// Disables the ending screen for accepted [Offer]
  TikiSdk disableAcceptEnding(bool disable) {
    _isAcceptEndingDisabled = disable;
    return this;
  }

  /// Disables the ending screen for decline [Offer]
  TikiSdk disableDeclineEnding(bool disable) {
    _isDeclineEndingDisabled = disable;
    return this;
  }

  /// Sets the callback function for an accepted offer.
  ///
  /// The onAccpet(...) event is triggered on the user's successful acceptance
  /// of the licensing offer. This happens after accepting the terms, not just
  /// on selecting "I'm In." The License Record is passed as a parameter to the
  /// callback function.
  TikiSdk setOnAccept(Function(Offer) onAccept) {
    _onAccept = onAccept;
    return this;
  }

  /// Sets the callback function for a declined offer
  ///
  /// he onDecline() event is triggered when the user declines the licensing offer.
  /// This happens on dismissal of the flow or when "Back Off" is selected.
  TikiSdk setOnDecline(Function(Offer) onDecline) {
    _onDecline = onDecline;
    return this;
  }

  /// Sets the callback function for user selecting the "settings" option in ending widget.
  ///
  /// The onSettings() event is triggered when the user selects "settings" in the
  /// ending screen. If a callback function is not registered, the SDK defaults to
  /// calling the TikiSdk.settings() method.
  TikiSdk setOnSettings(Function(Offer) onSettings) {
    _onSettings = onSettings;
    return this;
  }

  Future<String> _dbDir() async {
    final dir = await getApplicationDocumentsDirectory();
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir.path;
  }
}
