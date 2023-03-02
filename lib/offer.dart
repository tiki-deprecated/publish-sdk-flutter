/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiki_sdk_flutter/tiki_sdk.dart';
import 'package:uuid/uuid.dart';

import 'ui/used_bullet.dart';

/// An Offer for creating a License for a Title identified by [ptr].
class Offer {
  String? _id;
  String? _ptr;
  String? _description;
  String? _terms;
  Image? _reward;
  List<UsedBullet> _usedBullet = [];
  List<String> _uses = [];
  List<String> _tags = [];
  List<Permission> _requiredPermissions = [];
  DateTime? _expiry;

  /// The Offer unique identifier. If none is set, it creates a random UUID.
  String get id {
    _id ??= const Uuid().v4();
    return _id!;
  }

  /// An image that represents the reward.
  ///
  /// It should have 300x86 size and include assets for all screen depths.
  Image? get reward => _reward;

  /// The bullets that describes how the user data will be used.
  List<UsedBullet> get usedBullet => _usedBullet;

  /// The Pointer Record of the data stored.
  String get ptr => _ptr!;

  /// A human-readable description for the license.
  String? get description => _description;

  /// The legal terms of the offer.
  String? get terms => _terms;

  /// The Use cases for the license.
  List<String> get uses => _uses;

  /// The tags that describes the represented data asset.
  List<String> get tags => _tags;

  /// The expiration of the License. Null for no expiration.
  DateTime? get expiry => _expiry;

  /// A list of device-specific [Permission] required for the license.
  List<Permission> get requiredPermissions => _requiredPermissions;

  /// Sets the [id]
  Offer setId(String id) {
    _id = id;
    return this;
  }

  /// Sets the [reward]
  Offer setReward(Image reward) {
    reward = reward;
    return this;
  }

  /// Sets the [usedBullet]
  Offer setUsedBullet(List<UsedBullet> usedBullet) {
    _usedBullet = usedBullet;
    return this;
  }

  /// Adds a [usedBullet]
  Offer addUsedBullet(UsedBullet usedBullet) {
    _usedBullet.add(usedBullet);
    return this;
  }

  /// Sets the [ptr]
  Offer setPtr(String ptr) {
    _ptr = ptr;
    return this;
  }

  /// Sets the [description]
  Offer setDescription(String description) {
    _description = description;
    return this;
  }

  /// Sets the [terms]
  Offer setTerms(String terms) {
    _terms = terms;
    return this;
  }

  /// Sets the [uses]
  Offer setUses(List<String> uses) {
    _uses = uses;
    return this;
  }

  /// Adds an item in the [uses] list.
  Offer addUse(String use) {
    _uses.add(use);
    return this;
  }

  /// Sets the [tags]
  Offer setTags(List<String> tags) {
    _tags = tags;
    return this;
  }

  /// Adds an item in the [tags] list.
  Offer addTag(String tag) {
    _tags.add(tag);
    return this;
  }

  /// Sets the [expiry]
  Offer setExpiry(DateTime expiry) {
    _expiry = expiry;
    return this;
  }

  /// Sets the [requiredPermissions]
  Offer setReqPermissions(List<Permission> permissions) {
    _requiredPermissions = permissions;
    return this;
  }

  /// Adds an item in the [requiredPermissions] list.
  Offer addReqPermission(Permission permission) {
    _requiredPermissions.add(permission);
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
    TikiSdk.instance.addOffer(this);
    return TikiSdk.instance;
  }
}
