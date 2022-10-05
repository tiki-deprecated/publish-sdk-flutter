
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:tiki_sdk_dart/tiki_sdk.dart';
import 'package:tiki_sdk_flutter/utils/flutter_key_store.dart';


class TikiSdkFlutter {
  TikiSdk tikiSdkDart = TikiSdk();

  Future<TikiSdkFlutter> init(String origin, String apiKey, {String? id}) async {
    Database database = await _openDb(id);
    FlutterKeyStore keyStore = FlutterKeyStore();
    tikiSdkDart = await TikiSdk().init(origin, database, keyStore, apiKey, id: id);
    return this;
  }

  // TODO: mutiple dbs for diferent users
  Future<Database> _openDb(String? id) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String path = "$appDocPath/tiki_db.dart";
    final File f = File(path);
    if (!f.existsSync()) {
      var dir = Directory.fromUri(Uri.directory(path));
      if (!dir.parent.existsSync()) {
        dir.parent.createSync(recursive: true);
      }
    }
    return sqlite3.open(path);
  }

}
