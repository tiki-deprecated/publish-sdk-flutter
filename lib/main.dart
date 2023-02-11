/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// Not used. Required by Dart Runtime for native implementations
///@nodoc
import 'package:flutter/material.dart';
import 'src/tiki_platform_channel/tiki_platform_channel.dart';

export 'package:tiki_sdk_dart/cache/consent/consent_model.dart';
export 'package:tiki_sdk_dart/cache/ownership/ownership_model.dart';
export 'package:tiki_sdk_dart/tiki_sdk.dart';
export 'package:tiki_sdk_dart/tiki_sdk_data_type_enum.dart';
export 'package:tiki_sdk_dart/tiki_sdk_destination.dart';

export 'tiki_sdk_flutter_builder.dart';

/// The Dart entry point for Platform Channels integration.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  TikiPlatformChannel();
}
