import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:tiki_sdk_dart/consent/consent_service.dart';
import 'package:tiki_sdk_dart/node/l0_storage.dart';
import 'package:tiki_sdk_dart/tiki_sdk.dart';
import 'package:tiki_sdk_dart/tiki_sdk_builder.dart';
import 'package:tiki_sdk_flutter/tiki_sdk_flutter.dart';

import 'package:tiki_sdk_flutter/tiki_sdk_flutter_builder.dart';

import 'package:tiki_sdk_flutter/utils/flutter_key_store.dart';

import 'in_mem_storage.dart';

void main() {
  test('Import Dart TIKI SDK ', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    Database database = sqlite3.openInMemory();
    FlutterKeyStore keyStore = FlutterKeyStore();
    L0Storage l0storage = InMemL0Storage();
    TikiSdkBuilderStorage sdkBuilder = TikiSdkBuilderStorage('com.mytiki');
    sdkBuilder.keyStorage = keyStore;
    await sdkBuilder.loadPrimaryKey();
    sdkBuilder.database = database;
    sdkBuilder.l0Storage = l0storage;
    await sdkBuilder.buildSdk();
    expect(1, 1);
  });

  test('Initialize Flutter TIKI SDK', () async {
    L0Storage l0storage = InMemL0Storage();
    TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder('flutter test');
    builder.l0storage = l0storage;
    await builder.build();
    expect(1, 1);
  });

  test('Assign Ownership', () async {
    L0Storage l0storage = InMemL0Storage();
    TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder('flutter test');
    builder.l0storage = l0storage;
    await builder.build();
    TikiSdkFlutter tikiSdk = builder.tikiSdkFlutter;
    await tikiSdk.assignOwnership('test', TikiSdkDataTypeEnum.point, ['email']);
    expect(1, 1);
  });

  test('give and revoke consent', () async {
    L0Storage l0storage = InMemL0Storage();
    TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder('flutter test');
    builder.l0storage = l0storage;
    await builder.build();
    TikiSdkFlutter tikiSdk = builder.tikiSdkFlutter;
    String ownershipId = await tikiSdk
        .assignOwnership('test1', TikiSdkDataTypeEnum.point, ['email']);
    await tikiSdk.modifyConsent(ownershipId, const TikiSdkDestination.all());
    ConsentModel? consentGiven = tikiSdk.getConsent('test1');
    expect(consentGiven!.destination.uses[0], "*");
    expect(consentGiven.destination.paths[0], "*");
    await tikiSdk.modifyConsent(ownershipId, const TikiSdkDestination.none());
    consentGiven = tikiSdk.getConsent('test');
    expect(consentGiven!.destination.uses.isEmpty, true);
    expect(consentGiven.destination.paths.isEmpty, true);
  });

  test('expire consent', () async {
    bool ok = false;
    L0Storage l0storage = InMemL0Storage();
    TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder('flutter test');
    builder.l0storage = l0storage;
    await builder.build();
    TikiSdkFlutter tikiSdk = builder.tikiSdkFlutter;
    String ownershipId = await tikiSdk
        .assignOwnership('test2', TikiSdkDataTypeEnum.point, ['email']);
    await tikiSdk.modifyConsent(ownershipId, const TikiSdkDestination.all());
    await tikiSdk.applyConsent(
        'test2', const TikiSdkDestination.all(), () => ok = true);
    expect(ok, true);
    await tikiSdk.modifyConsent(ownershipId, const TikiSdkDestination.all(),
        expiry: DateTime.now());
    await tikiSdk.applyConsent(
        'test2', const TikiSdkDestination.all(), () => ok = false);
    expect(ok, false);
  });

  test('run a function based on user consent', () async {
    bool ok = false;
    L0Storage l0storage = InMemL0Storage();
    TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder('flutter test');
    builder.l0storage = l0storage;
    await builder.build();
    TikiSdkFlutter tikiSdk = builder.tikiSdkFlutter;
    String ownershipId = await tikiSdk
        .assignOwnership('test', TikiSdkDataTypeEnum.point, ['email']);
    await tikiSdk.modifyConsent(ownershipId, const TikiSdkDestination.all());
    ConsentModel? consentGiven = tikiSdk.getConsent('test3');
    expect(consentGiven!.destination.uses[0], "*");
    expect(consentGiven.destination.paths[0], "*");
    await tikiSdk.applyConsent(
        'test3', const TikiSdkDestination.all(), () => ok = true);
    expect(ok, true);
  });
}
