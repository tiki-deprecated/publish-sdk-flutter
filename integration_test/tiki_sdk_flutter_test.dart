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
    TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder()
      ..origin('com.mytiki.test')
      ..publishingId(publishingId);
    await builder.build();
    expect(1, 1);
  });

  test('Assign Ownership', skip: publishingId.isEmpty, () async {
    TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder()
      ..origin(origin)
      ..publishingId(publishingId);
    TikiSdk tikiSdk = await builder.build();
    await tikiSdk.assignOwnership('test', TikiSdkDataTypeEnum.point, ['email']);
    expect(1, 1);
  });

  test('Get Ownership', skip: publishingId.isEmpty, () async {
    TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder()
      ..origin(origin)
      ..publishingId(publishingId);
    TikiSdk tikiSdk = await builder.build();
    String ownershipId = await tikiSdk
        .assignOwnership('test', TikiSdkDataTypeEnum.point, ['email']);
    OwnershipModel getOwnership = tikiSdk.getOwnership('test')!;
    expect(ownershipId, Bytes.base64UrlEncode(getOwnership.transactionId!));
    expect(1, 1);
  });

  test('Give and revoke consent', skip: publishingId.isEmpty, () async {
    TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder()
      ..origin(origin)
      ..publishingId(publishingId);
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

  test('expire consent', skip: publishingId.isEmpty, () async {
    bool ok = false;
    TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder()
      ..origin(origin)
      ..publishingId(publishingId);
    TikiSdk tikiSdk = await builder.build();
    String ownershipId = await tikiSdk.assignOwnership(
        'expire consent test', TikiSdkDataTypeEnum.point, ['email']);
    await tikiSdk.modifyConsent(ownershipId, const TikiSdkDestination.all());
    await tikiSdk.applyConsent(
        'expire consent test', const TikiSdkDestination.all(), () => ok = true);
    expect(ok, true);
    await tikiSdk.modifyConsent(ownershipId, const TikiSdkDestination.all(),
        expiry: DateTime.now());
    await tikiSdk.applyConsent(
        'expire consent test', const TikiSdkDestination.all(), () => ok = true,
        onBlocked: (_) => ok = false);
    expect(ok, false);
  });

  test('run a function based on user consent', skip: publishingId.isEmpty, () async {
    bool ok = false;
    TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder()
      ..origin(origin)
      ..publishingId(publishingId);
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
