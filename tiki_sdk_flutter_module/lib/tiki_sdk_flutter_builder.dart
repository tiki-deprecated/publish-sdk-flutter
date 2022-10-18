import 'package:path_provider/path_provider.dart';
import 'package:tiki_sdk_dart/tiki_sdk.dart';

import 'tiki_sdk_flutter.dart';
import 'utils/flutter_key_storage.dart';

class TikiSdkFlutterBuilder {
  String? _address;
  String? _origin;
  String? _apiKey;
  String? _databaseDir;

  void address(String address) => _address = address;
  void origin(String origin) => _origin = origin;
  void apiKey(String apiKey) => _apiKey = apiKey;
  void databaseDir(String databaseDir) => _databaseDir = databaseDir;

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
