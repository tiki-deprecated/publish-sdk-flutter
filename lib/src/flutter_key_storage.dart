/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// Secure storage implementation for [KeyStorage]
library flutter_key_storage;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tiki_sdk_dart/node/key/key_storage.dart';
import 'package:tiki_sdk_dart/utils/rsa/rsa.dart';

/// The Flutter specific implementation of [KeyStorage].
///
/// It uses [FlutterSecureStorage] to implement encrypted key-value storage
/// for Android and iOS.
class FlutterKeyStorage implements KeyStorage {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  Future<String?> read(String key) async => await secureStorage.read(key: key);

  @override
  Future<void> write(String key, String value) async =>
      await secureStorage.write(key: key, value: value);

  @override
  Future<String> generate() async =>
      (await Rsa.generateAsync()).privateKey.encode();
}
