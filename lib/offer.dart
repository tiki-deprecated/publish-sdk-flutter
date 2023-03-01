/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

import 'ui/used_bullet.dart';

/// An Offer for creating a License for a Title identified by [ptr].
class Offer{
  Image? _reward;
  List<UsedBullet> _usedBullet = [];
  String? _ptr;
  String? _description;
  String? _terms;
  List<String> _uses = [];
  List<String> _tags = [];
  DateTime? _expiry;
  List<Permission> _requiredPermissions = [];

  /// An image that represents the reward.
  ///
  /// It should have 300x86 size and include assets for all screen depths.
  Image get reward => _reward!;

  /// The bullets that describes how the user data will be used.
  List<UsedBullet> get usedBullet => _usedBullet;

  /// The Pointer Record of the data stored.
  String get ptr => _ptr!;

  /// A human-readable description for the license.
  String get description => _description!;

  /// The legal terms of the offer.
  String get terms => _terms!;

  /// The Use cases for the license.
  List<String> get uses => _uses;

  /// The tags that describes the represented data asset.
  List<String> get tags => _tags;

  /// The expiration of the License. Null for no expiration.
  DateTime? get expiry => _expiry;

  /// A list of device-specific [Permission] required for the license.
  List<Permission> get requiredPermissions => _requiredPermissions;

  /// Sets the [_reward]
  void setReward(Image reward) => _reward = reward;

  /// Sets the [_usedBullet]
  void setUsedBullet(List<UsedBullet> usedBullet) => _usedBullet = usedBullet;

  /// Adds a [_usedBullet]
  void addUsedBullet(UsedBullet usedBullet) => _usedBullet.add(usedBullet);

  /// Sets the [_ptr]
  void setPtr(String ptr) => _ptr = ptr;

  /// Sets the [_description]
  void setDescription(String description) => _description = description;

  /// Sets the [_terms]
  void setTerms(String terms) => _terms = terms;

  /// Sets the [_uses]
  void setUses(List<String> uses) => _uses = uses;

  /// Adds an item in the [_uses] list.
  void addUse(String use) => _uses.add(use);

  /// Sets the [_tags]
  void setTags(List<String> tags) => _tags = tags;

  /// Adds an item in the [_tags] list.
  void addTag(String tag) => _tags.add(tag);

  /// Sets the [_expiry]
  void setExpiry(DateTime expiry) => _expiry = expiry;

  /// Sets the [requiredPermissions]
  void setReqPermissions(List<Permission> permissions) => _requiredPermissions = permissions;

  /// Adds an item in the [_requiredPermissions] list.
  void addReqPermission(Permission permission) => _requiredPermissions.add(permission);

}