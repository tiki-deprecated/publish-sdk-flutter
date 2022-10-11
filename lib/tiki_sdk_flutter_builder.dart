import 'package:path_provider/path_provider.dart';
import 'package:tiki_sdk_dart/node/l0_storage.dart';
import 'package:tiki_sdk_dart/tiki_sdk.dart';
import 'package:tiki_sdk_dart/tiki_sdk_builder.dart';

import 'package:path/path.dart' as p;

import 'tiki_sdk_flutter.dart';
import 'utils/flutter_key_storage.dart';

class TikiSdkFlutterBuilder {
  String? _address;
  String? _origin;
  String? _apiKey;

  void address(String address) => _address = address;
  void origin(String origin) => _origin = origin;
  void apiKey(String apiKey) => _apiKey = apiKey;

  Future<TikiSdkFlutter> build() async {
    String databaseDir = await _dbDir();
    TikiSdkBuilder sdkBuilder = TikiSdkBuilder()
      ..databaseDir(databaseDir)
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
    return p.join(dir.path, '$_address.db');
  }

}
