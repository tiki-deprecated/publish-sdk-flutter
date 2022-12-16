/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'package:tiki_sdk_flutter/tiki_sdk_flutter_resp.dart';

class TikiSdkFlutterRespError implements TikiSdkFlutterResp {
  String message;
  StackTrace? stackTrace;

  @override
  String requestId;

  TikiSdkFlutterRespError(this.requestId, this.message, this.stackTrace);

  TikiSdkFlutterRespError.fromError(Error e, this.requestId)
      : message = e.toString(),
        stackTrace = e.stackTrace;

  @override
  String toJson() => jsonEncode(
      {"requestId": requestId, "message": message, "stacktrace": stackTrace});
}
