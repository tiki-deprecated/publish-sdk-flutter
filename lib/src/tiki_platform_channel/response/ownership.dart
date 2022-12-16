/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import '../../../main.dart';
import '../tiki_platform_channel_resp.dart';

class TikiPlatformChannelRespOwnership extends TikiPlatformChannelResp {
  OwnershipModel? ownershipModel;

  TikiPlatformChannelRespOwnership(this.ownershipModel, requestId) : super(requestId);

  @override
  String toJson() => jsonEncode(
      {"ownershipModel": ownershipModel?.toJson(), "requestId": requestId});
}
