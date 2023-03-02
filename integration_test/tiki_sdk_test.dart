import 'package:flutter_test/flutter_test.dart';
import 'package:tiki_sdk_flutter/tiki_sdk.dart';

import 'tiki_credentials.dart' as credentials;

void main() {
  String publishingId = credentials.publishingId;

  test('Tiki SDK init', () async {
    TikiSdk tikiSdk = TikiSdk.init(publishingId);
    assert(tikiSdk.address != null);
  });
}