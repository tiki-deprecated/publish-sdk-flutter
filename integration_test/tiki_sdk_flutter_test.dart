import 'package:flutter_test/flutter_test.dart';
import 'package:tiki_sdk_flutter/main.dart';
import 'package:tiki_sdk_flutter/src/flutter_key_storage.dart';
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
    TikiSdkBuilder builder = TikiSdkBuilder()
      ..id(id)
      ..origin('com.mytiki.test')
      ..publishingId(publishingId);
    await builder.build();
    expect(1, 1);
  });

  test('Create a Title', skip: publishingId.isEmpty, () async {
    TikiSdkBuilder builder = TikiSdkBuilder()
      ..id(id)
      ..origin('com.mytiki.test')
      ..publishingId(publishingId);
    TikiSdk tikiSdk = await builder.build();
    await tikiSdk.title('test1');
    expect(1, 1);
  });

  test('Get a Title', skip: publishingId.isEmpty, () async {
    TikiSdkBuilder builder = TikiSdkBuilder()
      ..id(id)
      ..origin('com.mytiki.test')
      ..publishingId(publishingId);
    TikiSdk tikiSdk = await builder.build();
    TitleRecord title = await tikiSdk.title("teste");
    TitleRecord gotTitle = tikiSdk.getTitle(title.id)!;
    expect(title.hashedPtr, gotTitle.hashedPtr);
  });

  test('Create a License', skip: publishingId.isEmpty, () async {
    TikiSdkBuilder builder = TikiSdkBuilder()
      ..id(id)
      ..origin('com.mytiki.test')
      ..publishingId(publishingId);
    TikiSdk tikiSdk = await builder.build();
    List<LicenseUse> uses = [LicenseUse([LicenseUsecase.support()])];
    List<TitleTag> tags = [TitleTag.emailAddress()];
    String ptr = 'test2';
    LicenseRecord license = await tikiSdk.license(ptr, uses, "terms", tags: tags);
    TitleRecord? title = tikiSdk.getTitle(license.title.id);
    expect(title != null, true);
    expect(title!.id, license.title.id);
    expect(license.uses[0].usecases[0].value, uses[0].usecases[0].value);
  });


  test('Test guard return', skip: true, () async {
    bool ok = false;
    TikiSdkBuilder builder = TikiSdkBuilder()
      ..id(id)
      ..origin('com.mytiki.test')
      ..publishingId(publishingId);
    TikiSdk tikiSdk = await builder.build();
    List<LicenseUse> uses = [LicenseUse([LicenseUsecase.support()])];
    List<TitleTag> tags = [TitleTag.emailAddress()];
    String ptr = 'test3';
    await tikiSdk.license(ptr, uses, "terms", tags: tags);
    ok = tikiSdk.guard(ptr, uses[0].usecases);
    expect(ok, true);
  });
}
