/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:tiki_sdk_dart/cache/ownership/ownership_model.dart';
import 'rsp.dart';

/// The response for the `assignOwnership` and `getOwnership` method calls in
/// the Platform Channel.
///
/// Returns the [ownership] or Null if not found.
class RspOwnership extends Rsp {
  OwnershipModel? ownership;

  RspOwnership({this.ownership, String? requestId});

  @override
  String toJson() => jsonEncode({"ownership": ownership?.toMap()});
}
