/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
/// # The TIKI SDK for Flutter.
///
/// This SDK works as a wrapper for [TikiSdk], defining specific implementations
/// for Android and iOS.
///
/// ## How to use
///
/// Use [TikiSdkFlutterBuilder] to initialize the SDK.
///
/// ## API Reference
///
/// ### TikiSdkDataTypeEnum
///
/// The type of data to which the ownership refers.
/// * data_point
///   A specific and single ocurrence of a data.
/// * data_pool
///   A pool of data from different ocurrences.
/// * data_stream
///   A continuous stream of data.
///
/// ### TikiSdkDestination
///
/// The destination to which the data is consented to be used.
/// It is composed by `uses` and `paths`.
/// To allow all the constant is `TikiSdkDestination.all()`. To block all use `TikiSdkDestination.none()`.
///
/// #### uses
///
///  An optional list of application specific uses cases applicable to the given destination.<br />
///
///  Prefix with NOT to invert. _i.e. NOT ads_. </br >
///
/// #### paths
///
/// A list of paths, preferably URL without the scheme or reverse FQDN. Keep list short and use wildcard (*) matching. Prefix with NOT to invert. _i.e. NOT mytiki.com/*
///
/// #### WildCards
///
///  Wildcards are allowed in paths and uses using `*`.  To allow all uses, use a single item list with `*`.  To block all uses, create an empty list.
///
/// ### Assign Ownership
/// ```
/// String ownershipId = sdk.assignOwnership(source, type, contains, origin: origin);
/// ```
/// Assign ownership to a given `source` : data point, pool, or stream.<br />
/// The `types` describe the various types of data represented by the referenced data. <br />
/// Optionally, the `origin` can be overridden for the specific ownership grant.
///
/// ### Give Consent
/// ```
/// ConsentModel consent = sdk.modifyConsent(
///   ownershipId, destination, about: about, reward: reward, expiry: expiry);
/// ```
/// The consent is always given by overriding the previous consent. It is up to the implementer to verify the prior consent and modify it if necessary.
///
/// ### Get Consent
/// ```
/// ConsentModel consent = sdk. getConsent(source, origin: origin);
/// ```
/// Get the latest consent given for the source. The origin is optional and defaults to the one used in SDK builder.
///
/// ### Revoke Consent
/// ```
/// ConsentModel consent = sdk.modifyConsent(ownershipId, TikiSdkDestination.none());
/// ```
/// To revoke a given consent, use the constant TikiSdkDestition.none().
///
/// ### Apply Consent
/// ```
/// Function request = () => print('ok');
/// Function onBlocked = () => print('blocked');
/// sdk.applyConsent(source, destination, request, onBlocked: onBlocked);
/// ```
/// Runs a request if the consent was given for a specific source and destination. If the consent was not given, onBlocked is executed.
library tiki_sdk_flutter;

import 'package:tiki_sdk_dart/consent/consent_service.dart';
import 'package:tiki_sdk_dart/tiki_sdk.dart';

class TikiSdkFlutter {
  /// The base TIKI SDK for Dart
  late final TikiSdk tikiSdkDart;

  /// The default origin.
  final String origin;

  /// Initializes the TIKI SDK for Flutter, defining a default [origin].
  TikiSdkFlutter(this.origin);

  /// Assign ownership to a given [source].
  ///
  /// The [type] identifies which [TikiSdkDataTypeEnum] the ownership refers to.
  /// The list of items the data contains is described by [contains]. Optionally,
  /// a description about this ownership can be giben in [about] and the [origin]
  /// can be overridden for the specific ownership grant.
  /// It returns a base64 url-safe representation of the [OwnershipModel.transactionId].
  Future<String> assignOwnership(
          String source, TikiSdkDataTypeEnum type, List<String> contains,
          {String? origin}) async =>
      await tikiSdkDart.assignOwnership(source, type, contains, origin: origin);

  /// Gets latest consent given for a [source] and [origin].
  ///
  /// It does not validate if the consent is expired or if it can be applied to
  /// a specifi destination. For that, [applyConsent] should be used instead.
  ConsentModel? getConsent(String source, {String? origin}) =>
      tikiSdkDart.getConsent(source, origin: origin);

  /// Modify consent for an ownership identified by [ownershipId].
  ///
  /// The Ownership must be granted before modifying consent. Consent is applied
  /// on an explicit only basis. Meaning all requests will be denied by default
  /// unless the destination is explicitly defined in [destination].
  /// A blank list of [TikiSdkDestination.uses] or [TikiSdkDestination.paths]
  /// means revoked consent.
  Future<ConsentModel> modifyConsent(
          String ownershipId, TikiSdkDestination destination,
          {String? about, String? reward, DateTime? expiry}) async =>
      await tikiSdkDart.modifyConsent(ownershipId, destination,
          about: about, reward: reward, expiry: expiry);

  /// Apply consent for a given [source] and [destination].
  ///
  /// If consent exists for the destination and is not expired, [request] will be
  /// executed. Else [onBlocked] is called.
  Future<void> applyConsent(
          String source, TikiSdkDestination destination, Function request,
          {void Function(String)? onBlocked, String? origin}) async =>
      await tikiSdkDart.applyConsent(source, destination, request,
          onBlocked: onBlocked, origin: origin);
}
