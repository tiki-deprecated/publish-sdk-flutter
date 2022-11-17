/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiki_sdk_flutter/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Tiki Platform Channel', () {
    TikiSdkFlutterPlatform platform = TikiSdkFlutterPlatform();
    MethodChannel channel = platform.methodChannel;

    test('Build Sdk', () async {
      channel.invokeMethod(
          'buildSdk', {'apiKey': 'abc', 'origin': 'com.mytiki.test'});
    });
  });
}
