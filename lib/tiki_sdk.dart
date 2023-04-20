/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
library tiki_sdk;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/common.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:tiki_sdk_dart/cache/license/license_use.dart';
import 'package:tiki_sdk_dart/cache/license/license_usecase.dart';
import 'package:tiki_sdk_dart/cache/title/title_tag.dart';
import 'package:tiki_sdk_dart/license_record.dart';
import 'package:tiki_sdk_dart/tiki_sdk.dart' as core;
import 'package:tiki_sdk_dart/title_record.dart';

import 'src/flutter_key_storage.dart';
import 'src/widgets/offer_prompt.dart';
import 'src/widgets/settings.dart';
import 'ui/offer.dart';
import 'ui/theme.dart' as tiki_theme;

export 'package:tiki_sdk_dart/tiki_sdk.dart';

/// The TIKI SDK main class. Use this to add tokenized data ownership, consent, and rewards.
///
/// TikiSdk is a singleton that keeps the latest initialized instance. All the
/// parameters are kept when a new instance is created, except for the address
class TikiSdk {
  static TikiSdk? _instance;
  final tiki_theme.Theme _theme = tiki_theme.Theme();

  tiki_theme.Theme? _dark;
  core.TikiSdk? _core;

  Function(Offer, LicenseRecord?)? _onAccept;
  Function(Offer, LicenseRecord?)? _onDecline;
  Function(BuildContext) _onSettings = TikiSdk.settings;

  bool _isAcceptEndingDisabled = false;
  bool _isDeclineEndingDisabled = false;

  final Map<String, Offer> _offers = {};

  /// The singleton instance of the TikiSdk.
  ///
  /// Accessing this property always returns the same instance of the `TikiSdk`.
  /// This property provides a global point of access to the TikiSdk instance,
  /// allowing it to be easily used throughout your app.
  static TikiSdk get instance {
    _instance ??= TikiSdk._();
    return _instance!;
  }

  /// The default light theme for TikiSdk pre-built UIs.
  tiki_theme.Theme get theme => _theme;

  /// The dark theme for TikiSdk pre-built UIs. Just used if is set in TikiSdk.
  tiki_theme.Theme get dark {
    _dark ??= tiki_theme.Theme();
    return _dark!;
  }

  /// Creates a new Offer to be added in TikiSdk.
  Offer get offer => Offer();

  /// The map of possible [Offer] for the user, with its [Offer.id] as key.
  Map<String, Offer> get offers => _offers;

  /// Check if the ending screen is disabled for an declined [Offer].
  bool get isDeclineEndingDisabled => _isDeclineEndingDisabled;

  /// Check if the ending screen is disabled for an accepted [Offer].
  bool get isAcceptEndingDisabled => _isAcceptEndingDisabled;

  /// Callback function for an accepted offer.
  Function(Offer, LicenseRecord?)? get getOnAccept => _onAccept;

  /// Callback function for a declined offer.
  Function(Offer, LicenseRecord?)? get getOnDecline => _onDecline;

  /// Callback function for user tapping in settings in the settings link in
  /// ending screen.
  Function(BuildContext) get getOnSettings => _onSettings;

  /// Returns the `Theme` configured for the specified *colorScheme*, or the default theme if none is specified or the specified
  /// color scheme does not exist.
  ///
  /// If a dark theme has been defined and a color scheme of `.dark` is requested, the dark theme will be returned instead of the
  /// default theme.
  ///
  /// - Parameter colorScheme: The color scheme for which to retrieve the theme. If null, the default theme is returned.
  /// - Returns: The `Theme` configured for the specified color scheme, or the default theme if none is specified or the specified
  ///            color scheme does not exist.
  tiki_theme.Theme get activeTheme {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark && _dark != null ? dark : theme;
  }

  /// The wallet address that is in use.
  String? get address => _core?.address;

  /// The current id.
  String? get id => _core?.id;

  /// Private constructor to avoid direct initialization
  TikiSdk._();

  /// Adds an [Offer] object to the [offers] map, using its ID as the key.
  ///
  /// The [Offer] object is added to the [offers] mao with its ID as the key.
  /// If an offer with the same ID already exists in the dictionary, it will be
  /// overwritten by the new offer.
  TikiSdk addOffer(Offer offer) {
    _offers[offer.getId] = offer;
    return TikiSdk.instance;
  }

  /// Removes an [Offer] object from the [offers] dictionary, using its ID as the key.
  ///
  /// The [Offer] object with the specified ID is removed from the [offers] dictionary.
  /// If no offer with the specified ID is found in the dictionary, this method has no effect.
  TikiSdk removeOffer(String offerId) {
    _offers.remove(offerId);
    return TikiSdk.instance;
  }

  /// Disables or enables the ending UI for accepted offers.
  ///
  /// If this method is called with a parameter value of `true`, the ending UI
  /// will not be shown when an offer is accepted.
  /// If the parameter value is `false`, the ending UI will be shown as usual.
  TikiSdk disableAcceptEnding(bool disable) {
    _isAcceptEndingDisabled = disable;
    return this;
  }

  /// Disables or enables the ending UI for declined offers.
  ///
  /// If this method is called with a parameter value of `true`, the ending UI
  /// will not be shown when an offer is declined.
  /// If the parameter value is `false`, the ending UI will be shown as usual.
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
  TikiSdk onAccept(Function(Offer, LicenseRecord?) onAccept) {
    _onAccept = onAccept;
    return this;
  }

  /// Sets the callback function for a declined offer
  ///
  /// he onDecline() event is triggered when the user declines the licensing offer.
  /// This happens on dismissal of the flow or when "Back Off" is selected.
  TikiSdk onDecline(Function(Offer, LicenseRecord?) onDecline) {
    _onDecline = onDecline;
    return this;
  }

  /// Sets the callback function for user selecting the "settings" option in ending widget.
  ///
  /// The onSettings() event is triggered when the user selects "settings" in the
  /// ending screen. If a callback function is not registered, the SDK defaults to
  /// calling the TikiSdk.settings() method.
  TikiSdk onSettings(Function(BuildContext) onSettings) {
    _onSettings = onSettings;
    return this;
  }

  ///Initializes the TIKI SDK.
  ///
  /// Use this method to initialize the TIKI SDK with the specified *publishingId*, *id*, and *origin*.
  /// You can also provide an optional `onComplete` closure that will be executed once the initialization process is complete.
  /// - Parameters:
  ///    - publishingId: The *publishingId* for connecting to the TIKI cloud.
  ///   - id: The ID that uniquely identifies your user.
  ///   - onComplete: An optional closure to be executed once the initialization process is complete.
  ///   - origin: The default *origin* for all transactions. Defaults to `Bundle.main.bundleIdentifier` if *null*.
  /// - Throws: `TikiSdkError` if the initialization process encounters an error.
  Future<void> initialize(String publishingId, String id,
      {Function? onComplete = null,
      String? origin = null,
      String? dbDir = null}) async {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterKeyStorage keyStorage = FlutterKeyStorage();
    String address = await core.TikiSdk.withId(id, keyStorage);
    origin ??= (await PackageInfo.fromPlatform()).packageName;
    String dbFile = "${(dbDir ?? await _dbDir())}/$address.db";
    CommonDatabase database = sqlite3.open(dbFile);
    _core =
        await core.TikiSdk.init(publishingId, origin, keyStorage, id, database);
    if (onComplete != null) onComplete();
  }

  /// Returns a Boolean value indicating whether the TikiSdk has been initialized.
  ///
  /// If `true`, it means that the TikiSdk has been successfully initialized.
  /// If `false`, it means that the TikiSdk has not yet been initialized or has failed to initialize.
  bool get isInitialized => _core?.address != null;

  /// Guard against an invalid LicenseRecord for a list of usecases and destinations.
  ///
  /// Use this method to verify that a non-expired LicenseRecord for the specified pointer record exists and permits the listed usecases and destinations.
  ///
  /// This method can be used in two ways:
  /// 1. As an async traditional guard, returning a pass/fail boolean:
  /// ```
  /// let pass = await `guard`(ptr: "example-ptr", usecases: [.attribution], destinations: ["https://example.com"])
  /// if pass {
  ///     // Perform the action allowed by the LicenseRecord.
  /// }
  /// ```
  /// 2. As a wrapper around a function:
  /// ```
  /// `guard`(ptr: "example-ptr", usecases: [.attribution], destinations: ["https://example.com"], onPass: {
  ///     // Perform the action allowed by the LicenseRecord.
  /// }, onFail: { error in
  ///     // Handle the error.
  /// })
  /// ```
  ///
  /// - Parameters:
  ///   - ptr: The pointer record for the asset. Used to locate the latest relevant LicenseRecord.
  ///   - usecases: A list of usecases defining how the asset will be used.
  ///   - destinations: A list of destinations defining where the asset will be used, often URLs.
  ///   - onPass: A closure to execute automatically upon successfully resolving the LicenseRecord against the usecases and destinations.
  ///   - onFail: A closure to execute automatically upon failure to resolve the LicenseRecord. Accepts an optional error message describing the reason for failure.
  ///   - origin: An optional override of the default origin specified in the initializer.
  ///
  /// - Returns: `true` if the user has access, `false` otherwise.
  static Future<bool> guard(String ptr, List<LicenseUsecase> usecases,
      {List<String>? destinations = const [],
      String? origin,
      Function()? onPass,
      Function(String)? onFail}) async {
    return instance._core!.guard(ptr, usecases,
        destinations: destinations,
        origin: origin,
        onFail: onFail,
        onPass: onPass);
  }

  /// Presents an [Offer] to the user and allows them to accept or decline it, which can result in a new `LicenseRecord`
  /// being created based on the presented [Offer].
  ///
  /// If the [Offer] has already been accepted by the user, this method does nothing.
  ///
  /// This method creates a new `UIHostingController` that holds the Tiki SDK's pre-built user interface for the Offer
  /// prompt and presents it with the current root view controller. When the user finishes the `Offer` flow by dismissing it or
  /// accepting/declining the `Offer`, the root view controller is called again to dismiss the created hosting controller.
  ///
  /// It throws a [StateError] if the SDK is not initialized or if no `Offer` was created.
  static Future<void> present(BuildContext context) async {
    _throwIfNotInitialized();
    _throwIfNoOffers();
    String ptr = TikiSdk.instance.offers.values.first.getPtr;
    List<LicenseUsecase> usecases = [];
    List<String> destinations= [];
    TikiSdk.instance.offers.values.first.getUses.forEach( (licenseUse) {
      if(licenseUse.destinations != null){
        destinations.addAll(licenseUse.destinations!);
      }
      usecases.addAll(licenseUse.usecases);
    });
    await guard(ptr, usecases, destinations: destinations, onFail: (_) => showModalBottomSheet<dynamic>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) => OfferPrompt()));
  }

  /// Presents the Tiki SDK's pre-built user interface for the settings screen, which allows the user to accept or decline the current offer.
  ///
  /// This method creates a new `UIHostingController` that holds the Tiki SDK's pre-built user interface for the settings screen
  /// and presents it with the current root view controller. When the user dismisses the screen, the root view controller is called again
  /// to dismiss the created hosting controller.
  ///
  /// - Throws: `TikiSdkError` if the SDK is not initialized or if no `Offer` was created.
  static Future<void> settings(BuildContext context) async {
    _throwIfNotInitialized();
    _throwIfNoOffers();
    String ptr = TikiSdk.instance.offers.values.first.getPtr;
    List<LicenseUsecase> usecases = [];
    List<String> destinations= [];
    TikiSdk.instance.offers.values.first.getUses.forEach( (licenseUse) {
      if(licenseUse.destinations != null){
        destinations.addAll(licenseUse.destinations!);
      }
      usecases.addAll(licenseUse.usecases);
    });
    bool isAccepted = await guard(ptr, usecases, destinations: destinations);
    String terms =
      await DefaultAssetBundle.of(context).loadString(TikiSdk.instance.offers.values.first.getTerms);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Settings(isAccepted, terms)));
  }

  /// Starts the configuration process for the Tiki SDK instance.
  ///
  /// This method returns the shared instance of the Tiki SDK, which can be used to configure the SDK before initializing it.
  /// You can access instance variables such as `theme` or `offer`, and call methods such as `disableAcceptEnding(_:)`
  /// and `onAccept(_:)` on the returned instance to customize the SDK behavior to your needs.
  ///
  /// After the configuration is complete, you can initialize the SDK by calling `initialize(publishingId:id:onComplete:)`.
  /// Once the SDK is initialized, it is recommended to use the static methods instead of accessing the shared instance directly to
  /// avoid unnecessary dependency injection.
  ///
  /// To configure the Tiki SDK, you can use the builder pattern and chain the methods to customize the SDK behavior as needed.
  /// Here's an example:
  ///
  /// ```
  /// TikiSdk.config()
  ///    .theme
  ///        .primaryTextColor(.black)
  ///        .primaryBackgroundColor(.white)
  ///        .accentColor(.green)
  ///        .and()
  ///    .dark
  ///        .primaryTextColor(.white)
  ///        .primaryBackgroundColor(.black)
  ///        .accentColor(.green)
  ///        .and()
  ///    .offer
  ///        .bullet(text: "Use for ads", isUsed: true)
  ///        .bullet(text: "Share with 3rd party", isUsed: false)
  ///        .bullet(text: "Sell to other companies", isUsed: true)
  ///        .ptr("offer1")
  ///        .use(usecases: [LicenseUsecase(LicenseUsecaseEnum.support)])
  ///        .tag(TitleTag(TitleTagEnum.advertisingData))
  ///        .duration(365 * 24 * 60 * 60)
  ///        .permission(Permission.camera)
  ///        .terms("terms.md")
  ///        .add()
  ///    .onAccept { offer, license in ... }
  ///    .onDecline { offer, license in ... }
  ///    .disableAcceptEnding(false)
  ///    .disableDeclineEnding(true)
  ///    .initialize(publishingId: publishingId, id:id, onComplete: {...})
  /// ```
  ///
  /// - Returns: The shared instance of the Tiki SDK.
  static TikiSdk config() => instance;

  /// Creates a new `LicenseRecord` object.
  ///
  /// The method searches for a `TitleRecord` object that matches the provided `ptr` parameter. If such a record exists, the
  /// `tags` and `titleDescription` parameters are ignored. Otherwise, a new `TitleRecord` is created using the provided
  /// `tags` and `titleDescription` parameters.
  ///
  /// If the `origin` parameter is not provided, the default origin specified in initialization is used.
  /// The `expiry` parameter sets the expiration date of the `LicenseRecord`. If the license never expires, leave this parameter
  /// as `null`.
  ///
  /// - Parameters:
  ///   - ptr: The pointer record identifies data stored in your system, similar to a foreign key. Learn more about selecting good pointer
  ///   records at https://docs.mytiki.com/docs/selecting-a-pointer-record.
  ///   - uses: A list defining how and where an asset may be used, in the format of `LicenseUse` objects. Learn more about specifying
  ///   uses at https://docs.mytiki.com/docs/specifying-terms-and-usage.
  ///   - terms: The legal terms of the contract. This is a long text document that explains the terms of the license.
  ///   - tags: A list of metadata tags included in the `TitleRecord` describing the asset, for your use in record search and filtering.
  ///   This parameter is used only if a `TitleRecord` does not already exist for the provided `ptr`.
  ///   - titleDescription: A short, human-readable description of the `TitleRecord` as a future reminder. This parameter is used
  ///   only if a `TitleRecord` does not already exist for the provided `ptr`.
  ///   - licenseDescription: A short, human-readable description of the `LicenseRecord` as a future reminder.
  ///   - expiry: The expiration date of the `LicenseRecord`. If the license never expires, leave this parameter as `null`.
  ///   - origin: An optional override of the default origin specified in `init()`. Use a reverse-DNS syntax, e.g. `com.myco.myapp`.
  ///
  /// - Returns: The created `LicenseRecord` object.
  ///
  /// - Throws: `TikiSdkError` if the SDK is not initialized or if there is an error creating or saving the record.
  static Future<LicenseRecord> license(
      String ptr, List<LicenseUse> uses, String terms,
      {List<TitleTag>? tags = const [],
      String? titleDescription,
      String? licenseDescription,
      DateTime? expiry,
      String? origin}) {
    _throwIfNotInitialized();
    return instance._core!.license(
      ptr,
      uses,
      terms,
      titleDescription: titleDescription,
      licenseDescription: licenseDescription,
      expiry: expiry,
      origin: origin,
    );
  }

  /// Creates a new TitleRecord, or retrieves an existing one.
  ///
  /// Use this function to create a new TitleRecord for a given Pointer Record (ptr), or retrieve an existing one if it already exists.
  /// - Parameters:
  ///     - ptr: The Pointer Record that identifies the data stored in your system, similar to a foreign key. Learn more about selecting good pointer records at https://docs.mytiki.com/docs/selecting-a-pointer-record.
  ///     - origin: An optional override of the default origin specified in `initTikiSdkAsync`. Follow a reverse-DNS syntax,
  ///     i.e. com.myco.myapp.
  ///     - tags: A list of metadata tags included in the TitleRecord describing the asset, for your use in record search and filtering. Learn
  ///     more about adding tags at https://docs.mytiki.com/docs/adding-tags.
  ///     - description: A short, human-readable, description of the TitleRecord as a future reminder.
  /// - Returns: The created or retrieved TitleRecord.
  static Future<TitleRecord> title(String ptr,
      {List<TitleTag> tags = const [],
      String? description = null,
      String? origin = null}) async {
    _throwIfNotInitialized();
    return instance._core!
        .title(ptr, tags: tags, description: description, origin: origin);
  }

  /// Retrieves the TitleRecord with the specified ID, or `null` if the record is not found.
  ///
  /// Use this method to retrieve the metadata associated with an asset identified by its TitleRecord ID.
  /// - Parameters
  ///  - id: The ID of the TitleRecord to retrieve.
  static TitleRecord? getTitle(String id) {
    _throwIfNotInitialized();
    return instance._core!.getTitle(id);
  }

  /// Returns the LicenseRecord for a given ID or null if the license or corresponding title record is not found.
  ///
  /// This method retrieves the LicenseRecord object that matches the specified ID. If no record is found, it returns null. The `origin` parameter can be used to override the default origin specified in initialization.
  ///
  /// - Parameters
  ///     - id: The ID of the LicenseRecord to retrieve.
  ///     - origin: An optional override of the default origin specified in `initTikiSdkAsync`.
  /// - Returns: The LicenseRecord that matches the specified ID or null if the license or corresponding title record is not found.
  static LicenseRecord? getLicense(String id) {
    _throwIfNotInitialized();
    return instance._core!.getLicense(id);
  }

  /// Returns all LicenseRecords associated with a given Pointer Record.
  ///
  /// Use this method to retrieve all LicenseRecords that have been previously stored for a given Pointer Record in your system.
  ///
  /// - Parameters:
  ///    - ptr: The Pointer Record that identifies the data stored in your system, similar to a foreign key.
  ///    - origin: An optional origin. If null, the origin defaults to the package name.
  /// - Returns: An array of all LicenseRecords associated with the given Pointer Record. If no LicenseRecords are found,
  /// an empty array is returned.
  static List<LicenseRecord> all(String ptr, {String? origin = null}) {
    _throwIfNotInitialized();
    return instance._core!.all(ptr, origin: origin);
  }

  /// Returns the latest LicenseRecord for a ptr or null if the corresponding title or license records are not found.
  /// - Parameters:
  ///    - ptr: The Pointer Records identifies data stored in your system, similar to a foreign key.
  ///    - origin: An optional origin. If null, the origin defaults to the package name.
  ///
  /// - Returns: The latest LicenseRecord for the given ptr, or null if the corresponding title or license records are not found.
  static LicenseRecord? latest(String ptr, {String? origin = null}) {
    _throwIfNotInitialized();
    return instance._core!.latest(ptr, origin: origin);
  }

  Future<String> _dbDir() async {
    final dir = await getApplicationDocumentsDirectory();
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir.path;
  }

  static _throwIfNotInitialized() {
    if (!TikiSdk.instance.isInitialized) {
      throw StateError(
          "Please ensure that the TIKI SDK is properly initialized by calling initialize().");
    }
  }

  static _throwIfNoOffers() {
    if (TikiSdk.instance.offers.isEmpty) {
      throw StateError(
          "To proceed, kindly utilize the TikiSdk.offer() method to include at least one offer.");
    }
  }
}
