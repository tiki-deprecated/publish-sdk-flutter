/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// Not used. Required by Dart Runtime for native implementations
///@nodoc
import 'package:flutter/material.dart';

import 'tiki_sdk_flutter_platform.dart';

export 'package:tiki_sdk_dart/consent/consent_model.dart';
export 'package:tiki_sdk_dart/ownership/ownership_model.dart';
export 'package:tiki_sdk_dart/tiki_sdk.dart';
export 'package:tiki_sdk_dart/tiki_sdk_data_type_enum.dart';
export 'package:tiki_sdk_dart/tiki_sdk_destination.dart';

export 'tiki_sdk_flutter_builder.dart';
export 'tiki_sdk_flutter_platform.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  TikiSdkFlutterPlatform();
}
