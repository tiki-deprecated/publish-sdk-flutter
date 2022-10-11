import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tiki_sdk_dart/node/node_service.dart';

class FlutterKeyStorage implements KeyStorage {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  Future<String?> read({required String key}) async =>
      await secureStorage.read(key: key);

  @override
  Future<void> write({required String key, required String value}) async =>
      await secureStorage.write(key: key, value: value);
}
