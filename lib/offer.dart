/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import 'ui/used_bullet.dart';

/// An Offer for creating a License for a Title identified by [ptr].
class Offer{

  String? _id;
  
  /// A unique identifier for this Offer.
  ///
  /// A random id is created if none is set.
  String get id{
    _id ??= const Uuid().v4();
    return _id!;
  }

  /// Sets the unique id for the Offer.
  set id(String newId) => _id = newId;

  /// An image that represents the reward.
  ///
  /// It should have 300x86 size and include assets for all screen depths.
  Image? reward;

  /// The bullets that describes how the user data will be used.
  List<UsedBullet> usedBullet = [];

  /// The Pointer Record of the data stored.
  late String ptr;

  /// A human-readable description for the license.
  String? description;

  /// The legal terms of the offer.
  String? terms;

  /// The Use cases for the license.
  List<String> uses = [];

  /// The tags that describes the represented data asset.
  List<String> tags = [];

  /// The expiration of the License. Null for no expiration.
  DateTime? expiry;

  /// A list of device-specific [Permission] required for the license.
  List<Permission> requiredPermissions = [];

}


