/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'dart:typed_data';

import 'package:tiki_sdk_dart/node/backup/backup_client.dart';

class InMemL0Storage implements BackupClient {
  Map<String, Map<String, Uint8List>> storage = {};

  @override
  Future<void> write(String path, Uint8List obj) async {
    List<String> paths = path.split('/');
    String address = paths[0];
    String id = paths[1];
    if (storage[address] == null) storage[address] = {};
    storage[address]![id] = obj;
  }
}
