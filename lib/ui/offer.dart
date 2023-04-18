/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiki_sdk_dart/cache/license/license_use.dart';
import 'package:tiki_sdk_dart/cache/license/license_usecase.dart';
import 'package:tiki_sdk_dart/cache/title/title_tag.dart';
import 'package:tiki_sdk_flutter/tiki_sdk.dart';
import 'package:uuid/uuid.dart';

import 'bullet.dart';

/// An Offer for creating a License for a Title identified by [ptr].
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

  /// The Offer unique identifier. If none is set, it creates a random UUID.
  String get getId {
    _id ??= const Uuid().v4();
    return _id!;
  }

  /// An image that represents the reward.
  ///
  /// It should have 300x86 size and include assets for all screen depths.
  Image? get getReward => _reward;

  /// The bullets that describes how the user data will be used.
  List<Bullet> get getBullets => _bullets;

  /// The Pointer Record of the data stored.
  String get getPtr => _ptr!;

  /// A human-readable description for the license.
  String? get getDescription => _description;

  /// The legal terms of the offer.
  String get getTerms => _terms!;

  /// The Use cases for the license.
  List<LicenseUse> get getUses => _uses;

  /// The tags that describes the represented data asset.
  List<TitleTag> get getTags => _tags;

  /// The expiration of the License. Null for no expiration.
  DateTime? get getExpiry => _expiry;

  /// A list of device-specific [Permission] required for the license.
  List<Permission> get getPermissions => _permissions;

  /// Sets the [id]
  Offer id(String id) {
    _id = id;
    return this;
  }

  /// Sets the [reward]
  Offer reward(Image reward) {
    _reward = reward;
    return this;
  }

  /// Adds a [Bullet]
  Offer bullet(String text,bool isUsed) {
    _bullets.add(Bullet(text, isUsed));
    return this;
  }

  /// Sets the [ptr]
  Offer ptr(String ptr) {
    _ptr = ptr;
    return this;
  }

  /// Sets the [description]
  Offer description(String description) {
    _description = description;
    return this;
  }

  /// Sets the [terms]
  Offer terms(String terms) {
    _terms = terms;
    return this;
  }

  /// Sets the [uses]
  Offer uses(List<LicenseUse> uses) {
    _uses = uses;
    return this;
  }

  /// Adds an item in the [uses] list.
  Offer use(List<LicenseUsecase> usecases, {List<String> destinations = const []}) {
    _uses.add(LicenseUse(usecases, destinations: destinations));
    return this;
  }

  /// Sets the [tags]
  Offer tag(TitleTag tag) {
    _tags.add(tag);
    return this;
  }

  /// Sets the [expiry]
  Offer duration(Duration duration) {
    _expiry = DateTime.now().add(duration);
    return this;
  }

  /// Adds an item in the [requiredPermissions] list.
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
