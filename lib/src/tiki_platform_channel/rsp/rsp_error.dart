/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'rsp.dart';

class RspError extends Rsp {
  String? message;
  StackTrace? stackTrace;

  RspError({String? requestId, this.message, this.stackTrace})
      : super(requestId: requestId);

  RspError.fromError(Error e, {String? requestId})
      : message = e.toString(),
        stackTrace = e.stackTrace,
        super(requestId: requestId);

  @override
  String toJson() => jsonEncode({
        "requestId": requestId,
        "message": message,
        "stacktrace": stackTrace.toString()
      });
}
