import 'package:path_provider/path_provider.dart';
import 'package:tiki_sdk_dart/tiki_sdk.dart';

import 'tiki_sdk_flutter.dart';
import 'utils/flutter_key_storage.dart';

/// The TIKI SDK Flutter Builder
class TikiSdkFlutterBuilder {
  String? _address;
  String? _origin;
  String? _apiKey;
  String? _databaseDir;

  /// The address of the blockchain node.
  ///
  /// A new address will be defined if none is provided.
  void address(String address) => _address = address;

  /// The default origin for the ownership assignments.
  void origin(String origin) => _origin = origin;

  /// The apiKey to connect to TIKI L0 Storage.
  void apiKey(String apiKey) => _apiKey = apiKey;

  /// The directory to be used by SQLite to store the database.
  ///
  /// Defaults to Application Documents Directory.
  void databaseDir(String databaseDir) => _databaseDir = databaseDir;

  /// Builds a new [TikiSdkFlutter]
  Future<TikiSdkFlutter> build() async {
    TikiSdkBuilder sdkBuilder = TikiSdkBuilder()
      ..databaseDir(_databaseDir ?? await _dbDir())
      ..keyStorage(FlutterKeyStorage())
      ..address(_address)
      ..apiKey(_apiKey)
      ..origin(_origin!);
    TikiSdk tikiSdkDart = await sdkBuilder.build();
    TikiSdkFlutter tikiSdkFlutter = TikiSdkFlutter(_origin!);
    tikiSdkFlutter.tikiSdkDart = tikiSdkDart;
    return tikiSdkFlutter;
  }

  Future<String> _dbDir() async {
    final dir = await getApplicationDocumentsDirectory();
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir.path;
  }
}
