/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';


import '../../../main.dart';
import '../tiki_platform_channel_resp.dart';

class TikiPlatformChannelRespBuild implements TikiPlatformChannelResp {
  final TikiSdk tikiSdk;

  @override
  String requestId = "build";

  TikiPlatformChannelRespBuild(this.tikiSdk);

  @override
  String toJson() => jsonEncode({"address": tikiSdk.address});

}
