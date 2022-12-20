/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import '../../../main.dart';
import 'rsp.dart';

/// The response for the `assignOwnership` and `getOwnership` method calls in
/// the Platform Channel.
///
/// Returns the [ownership] or Null if not found.
class RspOwnership extends Rsp {
  OwnershipModel? ownership;

  RspOwnership({this.ownership, String? requestId})
      : super(requestId: requestId);

  @override
  String toJson() =>
      jsonEncode({"ownership": ownership?.toMap(), "requestId": requestId});
}
