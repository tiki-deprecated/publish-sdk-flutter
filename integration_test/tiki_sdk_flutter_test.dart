import 'package:flutter_test/flutter_test.dart';
import 'package:tiki_sdk_flutter/main.dart';
import 'package:tiki_sdk_flutter/tiki_sdk_flutter_key_storage.dart';

void main() {
  String apiId = '2b8de004-cbe0-4bd5-bda6-b266d54f5c90';
  String origin = 'com.mytiki.test';

  test('FlutterKeyStorage write and read', () async {
    TikiSdkFlutterKeyStorage keyStorage = TikiSdkFlutterKeyStorage();
    String value = 'test';
    keyStorage.write(key: 'test_value', value: 'test');
    String? returnedValue = await keyStorage.read(key: 'test_value');
    expect(returnedValue == null, false);
    expect(returnedValue, value);
  });

  test('Initialize Flutter TIKI SDK', skip: apiId.isEmpty, () async {
    TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder()
      ..origin('com.mytiki.test')
      ..apiId(apiId);
    await builder.build();
    expect(1, 1);
  });

  test('Assign Ownership', skip: apiId.isEmpty, () async {
    TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder()
      ..origin(origin)
      ..apiId(apiId);
    TikiSdk tikiSdk = await builder.build();
    await tikiSdk.assignOwnership('test', TikiSdkDataTypeEnum.point, ['email']);
    expect(1, 1);
  });

  test('Give and revoke consent', skip: apiId.isEmpty, () async {
    TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder()
      ..origin(origin)
      ..apiId(apiId);
    TikiSdk tikiSdk = await builder.build();
    String ownershipId = await tikiSdk.assignOwnership(
        'give and revoke consent test', TikiSdkDataTypeEnum.point, ['email']);
    await tikiSdk.modifyConsent(ownershipId, const TikiSdkDestination.all());
    ConsentModel? consentGiven =
        tikiSdk.getConsent('give and revoke consent test');
    expect(consentGiven!.destination.uses[0], "*");
    expect(consentGiven.destination.paths[0], "*");
    await tikiSdk.modifyConsent(ownershipId, const TikiSdkDestination.none());
    consentGiven = tikiSdk.getConsent('give and revoke consent test');
    expect(consentGiven!.destination.uses.isEmpty, true);
    expect(consentGiven.destination.paths.isEmpty, true);
  });

  test('expire consent', skip: apiId.isEmpty, () async {
    bool ok = false;
    TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder()
      ..origin(origin)
      ..apiId(apiId);
    TikiSdk tikiSdk = await builder.build();
    String ownershipId = await tikiSdk.assignOwnership(
        'expire consent test', TikiSdkDataTypeEnum.point, ['email']);
    await tikiSdk.modifyConsent(ownershipId, const TikiSdkDestination.all());
    await tikiSdk.applyConsent(
        'expire consent test', const TikiSdkDestination.all(), () => ok = true);
    expect(ok, true);
    await tikiSdk.modifyConsent(ownershipId, const TikiSdkDestination.all(),
        expiry: DateTime.now());
    await tikiSdk.applyConsent('expire consent test',
        const TikiSdkDestination.all(), () => ok = false);
    expect(ok, false);
  });

  test('run a function based on user consent', skip: apiId.isEmpty, () async {
    bool ok = false;
    TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder()
      ..origin(origin)
      ..apiId(apiId);
    TikiSdk tikiSdk = await builder.build();
    String ownershipId = await tikiSdk.assignOwnership(
        'run a function based on user consent test',
        TikiSdkDataTypeEnum.point,
        ['email']);
    await tikiSdk.modifyConsent(ownershipId, const TikiSdkDestination.all());
    ConsentModel? consentGiven =
        tikiSdk.getConsent('run a function based on user consent test');
    expect(consentGiven!.destination.uses[0], "*");
    expect(consentGiven.destination.paths[0], "*");
    await tikiSdk.applyConsent('run a function based on user consent test',
        const TikiSdkDestination.all(), () => ok = true);
    expect(ok, true);
  });
}
