/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:convert';

import 'rsp.dart';

/// The response for the errors thrown in the Platform Channel.
///
/// It returns the [message] of the error and the String representation of the
/// [stackTrace]
class RspError extends Rsp {
  String? message;
  StackTrace? stackTrace;

  RspError({String? requestId, this.message, this.stackTrace});

  RspError.fromError(Error e, {String? requestId})
      : message = e.toString(),
        stackTrace = e.stackTrace;

  @override
  String toJson() =>
      jsonEncode({"message": message, "stacktrace": stackTrace.toString()});
}
