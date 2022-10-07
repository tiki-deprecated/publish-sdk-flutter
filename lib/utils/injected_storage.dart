import 'dart:typed_data';

import 'package:tiki_sdk_dart/node/l0_storage.dart';

class InjectedStorage extends L0Storage {
  final Future<Uint8List?> Function(String) _read;
  final Future<void> Function(String, Uint8List) _write;
  final Future<Map<String, Uint8List>> Function(String) _getAll;

  InjectedStorage(this._read, this._write, this._getAll);

  @override
  Future<Map<String, Uint8List>> getAll(String address) => _getAll(address);

  @override
  Future<Uint8List?> read(String path) async => _read(path);

  @override
  Future<void> write(String path, Uint8List obj) async => _write(path, obj);
}
