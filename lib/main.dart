/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// Not used. Required by Dart Runtime for native implementations
///@nodoc
import 'package:flutter/material.dart';

import 'src/platform_channel/platform_channel.dart';

export 'package:tiki_sdk_dart/tiki_sdk.dart';

/// The Dart entry point for Platform Channels integration.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PlatformChannel();
}
