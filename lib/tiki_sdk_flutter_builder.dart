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
/// builder.apiId = <api_id;
/// ```
/// The apiId to connect to TIKI L0 Storage.
///
/// ### Database directory
/// ```
/// builder.databaseDir = 'path/to/database/directory'
/// ```
/// The directory to be used by SQLite to store the database.
/// If not provided, app documents directory will be used instead.
///
library tiki_sdk_flutter_builder;

import 'package:path_provider/path_provider.dart';
import 'package:tiki_sdk_dart/tiki_sdk.dart';

import 'tiki_sdk_flutter_key_storage.dart';

/// The TIKI SDK Flutter Builder
///
/// It handles [TikiSdk] initialization and defines default values for Flutter SDK.
class TikiSdkFlutterBuilder {
  String? _address;
  String? _origin;
  String? _apiId;
  String? _databaseDir;

  /// The address of the blockchain node.
  ///
  /// A new address will be defined if none is provided.
  void address(String address) => _address = address;

  /// The default origin for the ownership assignments.
  void origin(String origin) => _origin = origin;

  /// The apiId to connect to TIKI L0 Storage.
  void apiId(String apiId) => _apiId = apiId;

  /// The directory to be used by SQLite to store the database.
  ///
  /// Defaults to Application Documents Directory.
  void databaseDir(String databaseDir) => _databaseDir = databaseDir;

  /// Builds a new [TikiSdkFlutter]
  Future<TikiSdk> build() async {
    TikiSdkBuilder sdkBuilder = TikiSdkBuilder()
      ..databaseDir(_databaseDir ?? await _dbDir())
      ..keyStorage(TikiSdkFlutterKeyStorage())
      ..address(_address)
      ..apiId(_apiId)
      ..origin(_origin!);
    return sdkBuilder.build();
  }

  Future<String> _dbDir() async {
    final dir = await getApplicationDocumentsDirectory();
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir.path;
  }
}
