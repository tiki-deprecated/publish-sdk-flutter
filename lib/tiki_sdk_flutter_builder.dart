import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:tiki_sdk_dart/node/l0_storage.dart';
import 'package:tiki_sdk_dart/tiki_sdk_builder.dart';
import 'package:tiki_sdk_dart/tiki_sdk.dart';

import 'tiki_sdk_flutter.dart';
import 'utils/flutter_key_store.dart';

class TikiSdkFlutterBuilder {
  late final TikiSdkFlutter tikiSdkFlutter;
  late final TikiSdkBuilderStorage sdkBuilder;
  String _origin;
  String? _address;
  L0Storage? _l0storage;
  String? _apiKey;
  late String primaryKey;

  set address(String val) => _address = val;
  set origin(String val) => _origin = val;
  set l0storage(L0Storage val) => _l0storage = val;
  set apiKey(String val) => _apiKey = val;

  TikiSdkFlutterBuilder(this._origin) {
    sdkBuilder = TikiSdkBuilderStorage(_origin);
  }

  Future<void> build() async {
    await _loadPrimaryKey();
    _loadStorage();
    sdkBuilder.database = await _openDb();
    await sdkBuilder.buildSdk();
    TikiSdk tikiSdkDart = sdkBuilder.tikiSdk;
    tikiSdkFlutter = TikiSdkFlutter(_origin);
    tikiSdkFlutter.tikiSdkDart = tikiSdkDart;
  }

  Future<Database> _openDb() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String path = "$appDocPath/$_address.db";
    final File f = File(path);
    if (!f.existsSync()) {
      var dir = Directory.fromUri(Uri.directory(path));
      if (!dir.parent.existsSync()) {
        dir.parent.createSync(recursive: true);
      }
    }
    return sqlite3.open(path);
  }

  void _loadStorage() {
    if (_apiKey != null) {
      sdkBuilder.apiKey = _apiKey!;
    } else if (_l0storage != null) {
      sdkBuilder.l0Storage = _l0storage!;
    } else {
      throw Exception('Set apiKey or inject l0storage, for chain backup.');
    }
  }

  Future<void> _loadPrimaryKey() async {
    FlutterKeyStore keyStore = FlutterKeyStore();
    if (_address != null) sdkBuilder.address = _address!;
    sdkBuilder.keyStorage = keyStore;
    primaryKey = await sdkBuilder.loadPrimaryKey();
  }
}
