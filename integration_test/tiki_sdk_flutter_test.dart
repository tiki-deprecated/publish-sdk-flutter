import 'package:flutter_test/flutter_test.dart';
import 'package:tiki_sdk_dart/consent/consent_service.dart';
import 'package:tiki_sdk_dart/tiki_sdk.dart';
import 'package:tiki_sdk_flutter/tiki_sdk_flutter.dart';
import 'package:tiki_sdk_flutter/tiki_sdk_flutter_builder.dart';

void main() {
  String apiKey = '123';
  String origin = 'com.mytiki.test';

  test('Initialize Flutter TIKI SDK', skip: apiKey.isEmpty, () async {
    TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder()
      ..origin('com.mytiki.test')
      ..apiKey(apiKey);
    await builder.build();
    expect(1, 1);
  });

  test('Assign Ownership', skip: apiKey.isEmpty, () async {
    TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder()
      ..origin(origin)
      ..apiKey(apiKey);
    TikiSdkFlutter tikiSdk = await builder.build();
    await tikiSdk.assignOwnership('test', TikiSdkDataTypeEnum.point, ['email']);
    expect(1, 1);
  });

  test('Give and revoke consent', skip: apiKey.isEmpty, () async {
    TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder()
      ..origin(origin)
      ..apiKey(apiKey);
    TikiSdkFlutter tikiSdk = await builder.build();
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

  test('expire consent', skip: apiKey.isEmpty, () async {
    bool ok = false;
    TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder()
      ..origin(origin)
      ..apiKey(apiKey);
    TikiSdkFlutter tikiSdk = await builder.build();
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

  test('run a function based on user consent', skip: apiKey.isEmpty, () async {
    bool ok = false;
    TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder()
      ..origin(origin)
      ..apiKey(apiKey);
    TikiSdkFlutter tikiSdk = await builder.build();
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
