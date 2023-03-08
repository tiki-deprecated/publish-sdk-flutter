/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// # TIKI SDK Flutter Builder
///
/// It handles [TikiSdk] initialization and defines default values for Flutter SDK.
///
/// ## API Reference
///
/// ### Builder initialization
/// ```
/// TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder();
/// ```
///
/// ### Address
/// ```
/// builder.address = <base64URL encoded adress without padding>;
/// ```
/// The base64URL encoded address without padding of the blockchain node. A new
/// address will be defined if none is provided. [Bytes.base64UrlEncode] and
/// [Bytes.base64urlDecode] from [TikiSdk] can be used as helpers.
///
/// ### Origin
/// ```
/// builder.origin = 'com.mycompany.myapp';
/// ```
/// The default origin for the ownership assignments.
///
/// ### API id
/// ```
/// builder.publishingId = <api_id;
/// ```
/// The publishingId to connect to TIKI L0 Storage.
///
/// ### Database directory
/// ```
/// builder.databaseDir = 'path/to/database/directory'
/// ```
/// The directory to be used by SQLite to store the database.
/// If not provided, app documents directory will be used instead.
///
library tiki_sdk_flutter_builder;

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:tiki_sdk_dart/tiki_sdk.dart';

import 'flutter_key_storage.dart';

/// The TIKI SDK Flutter Builder
///
/// It handles [TikiSdk] initialization and defines default values for Flutter SDK.
class TikiSdkBuilder {
  String? _address;
  String? _origin;
  String? _publishingId;
  String? _databaseDir;

  /// The address of the blockchain node.
  ///
  /// A new address will be defined if none is provided.
  void address(String address) => _address = address;

  /// The default origin for the ownership assignments.
  void origin(String origin) => _origin = origin;

  /// The publishingId to connect to TIKI L0 Storage.
  void publishingId(String publishingId) => _publishingId = publishingId;

  /// The directory to be used by SQLite to store the database.
  ///
  /// Defaults to Application Documents Directory.
  void databaseDir(String databaseDir) => _databaseDir = databaseDir;

  /// Builds a new [TikiSdk] for Flutter.
  Future<TikiSdk> build() async {
    FlutterKeyStorage keyStorage = FlutterKeyStorage();
    WidgetsFlutterBinding.ensureInitialized();
    String addr = await TikiSdk.withAddress(keyStorage, address: _address);
    String dbDir = _databaseDir ?? await _dbDir();
    Database database = sqlite3.open("$dbDir/$addr.db");
    TikiSdk tikiSdk = await TikiSdk.init(
        _publishingId!, _origin!, keyStorage, addr, database);
    return tikiSdk;
  }

  Future<String> _dbDir() async {
    final dir = await getApplicationDocumentsDirectory();
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir.path;
  }
}
