import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:tiki_sdk_dart/tiki_sdk.dart';

import 'package:tiki_sdk_flutter/utils/flutter_key_store.dart';

import 'in_mem_storage.dart';

void main() {
  test('Import TIKI SDK', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    Database database = sqlite3.openInMemory();
    FlutterKeyStore keyStore = FlutterKeyStore();
    InMemL0Storage l0storage = InMemL0Storage();
    TikiSdk tikiSdk = await TikiSdk().init('flutter test', database, keyStore, l0storage);
    expect(1,1);
  });
}


