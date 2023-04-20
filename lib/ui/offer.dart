/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
/// {@category UI}
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiki_sdk_flutter/tiki_sdk.dart';
import 'package:uuid/uuid.dart';

import 'bullet.dart';

/// An Offer represents usage terms and conditions for a particular [TitleRecord].
/// Offers can be used to create or update a [LicenseRecord] in the pre-built UI.
class Offer {
  String? _id;
  String? _ptr;
  String? _description;
  String? _terms;
  Image? _reward;
  List<Bullet> _bullets = [];
  List<LicenseUse> _uses = [];
  List<TitleTag> _tags = [];
  List<Permission> _permissions = [];
  DateTime? _expiry;

  /// The unique identifier of the [Offer].
  ///
  /// If an [_id] was not defined with the [id] method, a random UUID string will
  /// be generated and used as the [_id].
  String get getId {
    _id ??= const Uuid().v4();
    return _id!;
  }

  /// An image that represents the reward.
  ///
  /// It should have 300x86 aspect ratio.
  Image? get getReward => _reward;

  /// An array of Bullet objects that describe the data usage permissions included
  /// in this Offer, to be shown in the pre-built UI.
  ///
  /// Each bullet provides a concise description of how the user's data will be
  /// used under this Offer.
  ///
  /// It contains a [text] property which describes the data usage and an [isUsed]
  /// property which indicates whether the data is being used or not.
  ///
  /// It is recommended to use the [bullet] method to manage the Offer bullets.
  /// This method adds a new [Bullet] object to the [_bullets] List with the
  /// specified text and usage status, ensuring that the bullets are correctly
  /// initialized and avoiding any potential overrides.
  ///
  /// Additionally, this method returns the [Offer] object to enable convenient
  /// chaining of method calls during offer initialization.
  /// For example:
  ///
  /// ```
  /// offer
  ///  .bullet("Your data will be used to personalize your experience", true)
  ///  .bullet("Your data will be shared with other companies", false)
  /// ```
  ///
  /// It is important to provide clear and accurate descriptions of data usage
  /// in the bullets to help users understand how their data will
  /// be used under this Offer. It will be shown in the pre-built UI.
  List<Bullet> get getBullets => _bullets;

  /// The pointer record for the [TitleRecord] to which this [Offer] applies.
  ///
  /// This property is used to create or find the TitleRecord for which the [Offer] applies.
  String get getPtr => _ptr!;

  /// A brief human-readable description for the license.
  /// This property is used to inform the user about the Offer, and is also used
  /// as the description for the [LicenseRecord] associated with this Offer.
  String? get getDescription => _description;

  /// The legal terms and conditions of the Offer.
  ///
  /// Use this property to specify detailed legal terms and conditions for the
  /// usage of the TitleRecord associated with this Offer.
  /// It supports basic markdown formatting and hyperlinks.
  ///
  /// To set the terms:
  /// - set the property directly with the markdown text through the [terms] method.
  ///```
  ///         offer.terms = "# Legal Terms and Conditions\n\nBy using this product, you agree to the following terms and conditions."
  ///```
  ///
  /// - Warning: The `terms` property must be set before calling the `add()` method,
  /// otherwise it will throw a [StateError].
  String get getTerms => _terms!;

  /// An array of [LicenseUse] that apply to this [Offer]. Each [LicenseUse]
  /// specifies how the [TitleRecord] can be used under this [Offer].
  ///
  /// This [use] method adds a new [LicenseUse] object to the [_uses] List with
  /// the specified usecases and destinations properties, ensuring that the [_uses] \
  /// List is correctly initialized and avoiding any potential overrides.
  ///
  /// Additionally, this method returns the Offer object to enable convenient
  /// chaining of method calls during offer initialization.
  ///
  /// For example:
  ///```
  /// offer
  ///  .use(LicenceUsecase.support(), destinations: ["*.example.com"])
  ///  .use(LicenceUsecase.add_attribution(), destinations: ["*.myco.com"])
  ///```
  List<LicenseUse> get getUses => _uses;

  /// An array of [TitleTag] that apply to this [Offer].
  ///
  /// Each [TitleTag] is a representation of a tag that describes a data asset
  /// within a the [TitleRecord] to which this offer refers.
  ///
  /// Use the [tag] method to manage the Offer tags. This method adds a new [TitleTag]
  /// object to the [_tags] List ensuring that the [_tags] List is correctly initialized and avoiding
  /// any potential overrides.
  ///
  /// Additionally, this method returns the Offer object to enable convenient
  /// chaining of method calls during offer initialization.
  /// For example:
  ///```
  /// offer
  ///  .tag(TitleTag.advertisingData())
  ///  .tag(TitleTag.creditInfo())
  ///```
  List<TitleTag> get getTags => _tags;

  /// The expiration date of the [LicenseRecord] applied to this [Offer].
  ///
  /// If this property is set, the [LicenseRecord] associated with this [Offer]
  /// will expire on the specified date.
  ///
  /// Use the public method [duration] to set the expiry date based on the duration
  /// of the license, rather than setting it manually. This method calculates the
  /// expiry date by adding the specified time interval to the current date,
  /// and returns the [Offer] object to enable convenient chaining of method
  /// calls during offer initialization.
  ///
  /// If the expiry date is not set, the [LicenseRecord] associated with this [Offer]
  /// will never expire.
  DateTime? get getExpiry => _expiry;

  /// An array of [Permission] required for this [Offer].
  ///
  /// Use the [permission] method to manage the Offer permissions.
  /// This method adds a new `Permission` object to the [_permissions] array
  /// ensuring that the `permissions` array is correctly initialized and avoiding
  /// any potential overrides.
  ///
  /// Additionally, this method returns the Offer object to enable convenient
  /// chaining of method calls during offer initialization.
  ///
  /// Additionally, this method returns the Offer object to enable convenient
  /// chaining of method calls during offer initialization.
  List<Permission> get getPermissions => _permissions;

  /// Sets the unique identifier for this Offer.
  ///
  /// The `id` parameter must be a non-empty String that uniquely identifies the Offer.
  ///
  /// - Parameter id: A String representing the unique identifier for the Offer. Must not be `nil` or empty.
  /// - Returns: The modified Offer object.
  ///
  /// The `id` parameter is not set, a random UUID will be used when adding the Offer in TikiSdk.
  ///
  /// Additionally, this method returns the Offer object to enable convenient
  /// chaining of method calls during offer initialization.
  Offer id(String id) {
    _id = id;
    return this;
  }

  /// Defines the image that represents the Offer.
  ///
  /// This method defines the image that will be used to illustrate the Offer.
  ///
  /// Additionally, this method returns the Offer object to enable convenient
  /// chaining of method calls during offer initialization.
  Offer reward(Image reward) {
    _reward = reward;
    return this;
  }

  /// An array of Bullet objects that describe the data usage permissions included
  /// in this Offer, to be shown in the pre-built UI.
  ///
  /// Each bullet provides a concise description of how the user's data will be
  /// used under this Offer.
  ///
  /// It contains a [text] property which describes the data usage and an [isUsed]
  /// property which indicates whether the data is being used or not.
  ///
  /// Additionally, this method returns the Offer object to enable convenient
  /// chaining of method calls during offer initialization.
  Offer bullet(String text, bool isUsed) {
    _bullets.add(Bullet(text, isUsed));
    return this;
  }

  /// Sets the pointer record of the data asset associated to this Offer.
  ///
  /// Additionally, this method returns the Offer object to enable convenient
  /// chaining of method calls during offer initialization.
  Offer ptr(String ptr) {
    _ptr = ptr;
    return this;
  }

  /// Sets the [_description] of this Offer.
  ///
  /// Additionally, this method returns the Offer object to enable convenient
  /// chaining of method calls during offer initialization.
  Offer description(String description) {
    _description = description;
    return this;
  }

  /// Sets the file that contains legal terms and conditions of the Offer.
  ///
  /// Use this method to specify detailed legal terms and conditions for the usage
  /// of the TitleRecord associated with this Offer. It supports basic markdown formatting
  /// and hyperlinks.
  ///
  /// Additionally, this method returns the Offer object to enable convenient
  /// chaining of method calls during offer initialization.
  Offer terms(String terms) {
    _terms = terms;
    return this;
  }

  /// Adds a LicenceUse to the Offer.
  ///
  /// This method adds a new [LicenseUse] object to the `uses` array with the specified
  /// usecases and destinations properties, ensuring that the `uses` array is correctly
  /// initialized and avoiding any potential overrides.
  ///
  /// Additionally, this method returns the Offer object to enable convenient
  /// chaining of method calls during offer initialization.
  Offer use(List<LicenseUsecase> usecases,
      {List<String> destinations = const []}) {
    _uses.add(LicenseUse(usecases, destinations: destinations));
    return this;
  }

  /// Adds a [TitleTag] that describe the data attached to this [Offer].
  Offer tag(TitleTag tag) {
    _tags.add(tag);
    return this;
  }

  /// Determine the duration of the [LicenseRecord] applied to this [Offer].
  ///
  /// This method calculates the [LicenseRecord.expiry] date by adding the specified
  /// time interval to the current date, and returns the [Offer` object to enable
  /// convenient chaining of method calls during offer initialization.
  Offer duration(Duration duration) {
    _expiry = DateTime.now().add(duration);
    return this;
  }

  /// Adds a new required [Permission] for this [Offer].
  ///
  /// This method adds a new [Permission] object to the [_permissions] List.
  ///
  /// It returns the [Offer] object to enable convenient chaining of method calls
  /// during offer initialization.
  Offer permission(Permission permission) {
    _permissions.add(permission);
    return this;
  }

  /// Adds the built Offer to the [TikiSdk.offers] list
  TikiSdk add() {
    if (_ptr == null) {
      throw ArgumentError("Set the Offer pointer record (ptr).");
    }
    if (_uses.isEmpty) {
      throw ArgumentError("Add at lease one License use case to the Offer.");
    }
    if (_terms == null) {
      throw ArgumentError("Set the offer terms.");
    }
    TikiSdk.instance.addOffer(this);
    return TikiSdk.instance;
  }
}
