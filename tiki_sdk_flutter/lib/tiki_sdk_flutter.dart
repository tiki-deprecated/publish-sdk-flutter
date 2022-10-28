import 'package:tiki_sdk_dart/consent/consent_service.dart';
import 'package:tiki_sdk_dart/tiki_sdk.dart';

/// The TIKI SDK for Flutter.
///
/// This SDK works as a wrapper for TIKI SDK Dart, defining specific implementations
/// for Android and iOS.
class TikiSdkFlutter {

  /// The base TIKI SDK for Dart
  late final TikiSdk tikiSdkDart;

  /// The default origin.
  final String origin;

  /// Initializes the TIKI SDK for Flutter, defining a default [origin].
  TikiSdkFlutter(this.origin);

  /// Assigns ownership to a given [source] : data point, pool, or stream.
  /// [types] describe the various types of data represented by
  /// the referenced data. Optionally, the [origin] can be overridden
  /// for the specific ownership grant.
  Future<String> assignOwnership(
          String source, TikiSdkDataTypeEnum type, List<String> contains,
          {String? origin}) async =>
      await tikiSdkDart.assignOwnership(source, type, contains);

  /// Gets latest consent given to a specific [source] and [origin].
  ///
  /// If no [origin] is provided, the default will be used.
  ConsentModel? getConsent(String source, {String? origin}) =>
      tikiSdkDart.getConsent(source);

  /// Modify consent for [data]. Ownership must be granted before
  /// modifying consent. Consent is applied on an explicit only basis.
  /// Meaning all requests will be denied by default unless the
  /// destination is explicitly defined in [destinations].
  /// A blank list of [TikiSdkDestination.uses] or [TikiSdkDestination.paths]
  /// means revoked consent.
  Future<ConsentModel> modifyConsent(
          String ownershipId, TikiSdkDestination destination,
          {String? about, String? reward, DateTime? expiry}) async =>
      await tikiSdkDart.modifyConsent(ownershipId, destination,
          about: about, expiry: expiry);

  /// Apply consent for [data] given a specific [destination].
  /// If consent exists for the destination, [request] will be
  /// executed. Else [onBlocked] is called.
  Future<void> applyConsent(
          String source, TikiSdkDestination destination, Function request,
          {void Function(String)? onBlocked, String? origin}) async =>
      await tikiSdkDart.applyConsent(source, destination, request,
          onBlocked: onBlocked, origin: origin);
}
