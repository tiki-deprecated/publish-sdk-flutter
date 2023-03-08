import 'package:flutter_test/flutter_test.dart';
import 'package:tiki_sdk_flutter/main.dart';
import 'package:tiki_sdk_flutter/src/flutter_key_storage.dart';
import 'tiki_credentials.dart' as credentials;

void main() {
  String publishingId = credentials.publishingId;
  String origin = 'com.mytiki.test';

  test('FlutterKeyStorage write and read', () async {
    FlutterKeyStorage keyStorage = FlutterKeyStorage();
    String value = 'test';
    keyStorage.write(key: 'test_value', value: 'test');
    String? returnedValue = await keyStorage.read(key: 'test_value');
    expect(returnedValue == null, false);
    expect(returnedValue, value);
  });

  test('Initialize Flutter TIKI SDK', skip: publishingId.isEmpty, () async {
    TikiSdkBuilder builder = TikiSdkBuilder()
      ..origin('com.mytiki.test')
      ..publishingId(publishingId);
    await builder.build();
    expect(1, 1);
  });

  test('Create a Title', skip: publishingId.isEmpty, () async {
    TikiSdkBuilder builder = TikiSdkBuilder()
      ..origin(origin)
      ..publishingId(publishingId);
    TikiSdk tikiSdk = await builder.build();
    await tikiSdk.title('test');
    expect(1, 1);
  });

  test('Get a Title', skip: publishingId.isEmpty, () async {
    TikiSdkBuilder builder = TikiSdkBuilder()
      ..origin(origin)
      ..publishingId(publishingId);
    TikiSdk tikiSdk = await builder.build();
    TitleRecord title = await tikiSdk.title("teste");
    TitleRecord gotTitle = tikiSdk.getTitle(title.id)!;
    expect(title.ptr, gotTitle.ptr);
  });

  // test('run a function based on user license', skip: publishingId.isEmpty, () async {
  //   bool ok = false;
  //   TikiSdkBuilder builder = TikiSdkBuilder()
  //     ..origin(origin)
  //     ..publishingId(publishingId);
  //   TikiSdk tikiSdk = await builder.build();
  //   String titleId = await tikiSdk.assignTitle(
  //       'run a function based on user license test',
  //       TikiSdkDataTypeEnum.point,
  //       ['email']);
  //   await tikiSdk.modifyConsent(titleId, const TikiSdkDestination.all());
  //   LicenseRecord? licenseGiven =
  //       tikiSdk.getConsent('run a function based on user license test');
  //   expect(licenseGiven!.destination.uses[0], "*");
  //   expect(licenseGiven.destination.paths[0], "*");
  //   await tikiSdk.applyConsent('run a function based on user license test',
  //       const TikiSdkDestination.all(), () => ok = true);
  //   expect(ok, true);
  // });
}
