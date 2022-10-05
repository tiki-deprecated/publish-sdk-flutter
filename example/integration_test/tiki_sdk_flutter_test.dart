import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:tiki_sdk_dart/tiki_sdk.dart';
import 'package:tiki_sdk_flutter/tiki_sdk_flutter.dart';

import 'package:tiki_sdk_flutter/utils/flutter_key_store.dart';

void main() {
  test('Import Dart TIKI SDK ', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    Database database = sqlite3.openInMemory();
    FlutterKeyStore keyStore = FlutterKeyStore();
    String apiKey = '';
    await TikiSdk().init('flutter test', database, keyStore, apiKey);
    expect(1,1);
  });
  test('Initialize Flutter TIKI SDK', () async {
    String apiKey = '';
    await TikiSdkFlutter().init('flutter test', apiKey);
    expect(1,1);
  });
}


