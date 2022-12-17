/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import '../../../main.dart';
import 'rsp.dart';

class RspOwnership extends Rsp {
  OwnershipModel? ownership;

  RspOwnership({this.ownership, String? requestId})
      : super(requestId: requestId);

  @override
  String toJson() =>
      jsonEncode({"ownership": ownership?.toJson(), "requestId": requestId});
}
