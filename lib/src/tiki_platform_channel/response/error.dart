/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import '../tiki_platform_channel_resp.dart';


class TikiPlatformChannelRespError implements TikiPlatformChannelResp {
  String message;
  StackTrace? stackTrace;

  @override
  String requestId;

  TikiPlatformChannelRespError(this.requestId, this.message, this.stackTrace);

  TikiPlatformChannelRespError.fromError(Error e, this.requestId)
      : message = e.toString(),
        stackTrace = e.stackTrace;

  @override
  String toJson() => jsonEncode(
      {"requestId": requestId, "message": message, "stacktrace": stackTrace});
}
