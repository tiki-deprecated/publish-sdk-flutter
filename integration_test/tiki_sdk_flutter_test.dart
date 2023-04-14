import 'package:flutter_test/flutter_test.dart';
import 'package:tiki_sdk_dart/cache/license/license_use.dart';
import 'package:tiki_sdk_dart/cache/license/license_usecase.dart';
import 'package:tiki_sdk_dart/cache/title/title_tag.dart';
import 'package:tiki_sdk_dart/license_record.dart';
import 'package:tiki_sdk_dart/title_record.dart';
import 'package:tiki_sdk_flutter/src/platform_channel/flutter_key_storage.dart';
import 'package:tiki_sdk_flutter/tiki_sdk.dart';
import 'package:uuid/uuid.dart';

import 'tiki_credentials.dart' as credentials;

void main() {
  String publishingId = credentials.publishingId;
  String id = Uuid().v4();

  test('FlutterKeyStorage write and read', () async {
    FlutterKeyStorage keyStorage = FlutterKeyStorage();
    String value = 'test';
    keyStorage.write('test_value', 'test');
    String? returnedValue = await keyStorage.read('test_value');
    expect(returnedValue == null, false);
    expect(returnedValue, value);
  });

  test('Initialize Flutter TIKI SDK', skip: publishingId.isEmpty, () async {
    await TikiSdk.config().initialize(publishingId, id, origin: 'com.mytiki.test');
    expect(TikiSdk.instance.address != null, true);
  });

  test('Create a Title', skip: publishingId.isEmpty, () async {
    await TikiSdk.config().initialize(publishingId, id, origin: 'com.mytiki.test');
    TitleRecord title = await TikiSdk.title('test1');
    expect(false, title.hashedPtr.isEmpty);
  });

  test('Get a Title', skip: publishingId.isEmpty, () async {
    await TikiSdk.config().initialize(publishingId, id, origin: 'com.mytiki.test');
    TitleRecord title = await TikiSdk.title("teste");
    TitleRecord gotTitle = TikiSdk.getTitle(title.id)!;
    expect(title.hashedPtr, gotTitle.hashedPtr);
  });

  test('Create a License', skip: publishingId.isEmpty, () async {
    await TikiSdk.config().initialize(publishingId, id, origin: 'com.mytiki.test');
    List<LicenseUse> uses = [LicenseUse([LicenseUsecase.support()])];
    List<TitleTag> tags = [TitleTag.emailAddress()];
    String ptr = 'test2';
    LicenseRecord license = await TikiSdk.license(ptr, uses, "terms", tags: tags);
    TitleRecord? title = TikiSdk.getTitle(license.title.id);
    expect(title != null, true);
    expect(title!.id, license.title.id);
    expect(license.uses[0].usecases[0].value, uses[0].usecases[0].value);
  });


  test('Test guard return', skip: true, () async {
    bool ok = false;
    await TikiSdk.config().initialize(publishingId, id, origin: 'com.mytiki.test');
    List<LicenseUse> uses = [LicenseUse([LicenseUsecase.support()])];
    List<TitleTag> tags = [TitleTag.emailAddress()];
    String ptr = 'test3';
    await TikiSdk.license(ptr, uses, "terms", tags: tags);
    ok = await TikiSdk.guard(ptr, uses[0].usecases);
    expect(ok, true);
  });
}
