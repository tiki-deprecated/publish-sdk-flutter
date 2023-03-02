import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiki_sdk_flutter/tiki_sdk.dart';

import 'offer.dart';
import 'ui/used_bullet.dart';

class OfferBuilder{
  
  Offer _offer = Offer();

  /// Sets the [_offer.id]
  void setId(String id) => _offer.id = id;

  /// Sets the [_offer.reward]
  void setReward(Image reward) => _offer.reward = reward;

  /// Sets the [_offer.usedBullet]
  void setUsedBullet(List<UsedBullet> usedBullet) => _offer.usedBullet = usedBullet;

  /// Adds a [_offer.usedBullet]
  void addUsedBullet(UsedBullet usedBullet) => _offer.usedBullet.add(usedBullet);

  /// Sets the [_offer.ptr]
  void setPtr(String ptr) => _offer.ptr = ptr;

  /// Sets the [_offer.description]
  void setDescription(String description) => _offer.description = description;

  /// Sets the [_offer.terms]
  void setTerms(String terms) => _offer.terms = terms;

  /// Sets the [_offer.uses]
  void setUses(List<String> uses) => _offer.uses = uses;

  /// Adds an item in the [_offer.uses] list.
  void addUse(String use) => _offer.uses.add(use);

  /// Sets the [_offer.tags]
  void setTags(List<String> tags) => _offer.tags = tags;

  /// Adds an item in the [_offer.tags] list.
  void addTag(String tag) => _offer.tags.add(tag);

  /// Sets the [_offer.expiry]
  void setExpiry(DateTime expiry) => _offer.expiry = expiry;

  /// Sets the [requiredPermissions]
  void setReqPermissions(List<Permission> permissions) => _offer.requiredPermissions = permissions;

  /// Adds an item in the [_offer.requiredPermissions] list.
  void addReqPermission(Permission permission) => _offer.requiredPermissions.add(permission);

  /// Adds the built Offer to the [TikiSdk.offers] list
  void add(){
    if(_offer.ptr == null) throw ArgumentError("Set the Offer pointer record (ptr).");
    if(_offer.uses.isEmpty) throw ArgumentError("Add at lease one License use case to the Offer.");
    TikiSdk.addOffer(_offer);
  }

  /// Resets the Offer object.
  void reset(){
    _offer = Offer();
  }
}