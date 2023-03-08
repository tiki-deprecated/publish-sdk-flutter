import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiki_sdk_dart/cache/license/license_use.dart';
import 'package:tiki_sdk_dart/cache/license/license_usecase_enum.dart';
import 'package:tiki_sdk_dart/cache/title/title_tag_enum.dart';
import 'package:tiki_sdk_flutter/src/tiki_platform_channel/tiki_platform_channel.dart';
import 'tiki_credentials.dart' as credentials;

void main() {
  String publishingId = credentials.publishingId;
  const String origin = 'com.mytiki.test';

  Map<String, Completer<String>> completers = {};

  handler(MethodCall methodCall) async {
    String jsonResponse = methodCall.arguments["response"];
    String requestId = methodCall.arguments["requestId"];
    Completer<String>? completer = completers[requestId];
    if (completer != null) completer.complete(jsonResponse);
  }

  TestWidgetsFlutterBinding.ensureInitialized();
  TikiPlatformChannel platform = TikiPlatformChannel();
  MethodChannel channel = platform.methodChannel;

  TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, handler);

  group('TikiSdkFlutterPlatform tests', () {
    test('Build Sdk - no address', () async {
      Completer<String> completer = Completer();
      String requestId = 'build';
      completers[requestId] = completer;
      await channel.invokeMockMethod('build', {
        "requestId": requestId,
        "request": jsonEncode({"publishingId": publishingId, "origin": origin})
      });
      String jsonResponse = await completer.future;
      expect(jsonDecode(jsonResponse)["address"].length > 32, true);
    });

    test('Build Sdk - providing address', () async {
      Completer<String> completer = Completer();
      String requestId = 'build';
      completers[requestId] = completer;
      await channel.invokeMockMethod('build', {
        "requestId": requestId,
        "request": jsonEncode({"publishingId": publishingId, "origin": origin})
      });
      String jsonResponse = await completer.future;
      String address = jsonDecode(jsonResponse)["address"];

      completer = Completer();
      completers[requestId] = completer;
      await channel.invokeMockMethod('build', {
        "requestId": requestId,
        "request": jsonEncode({
          "publishingId": publishingId,
          "origin": origin,
          "address": address
        })
      });
      jsonResponse = await completer.future;
      expect(address, jsonDecode(jsonResponse)["address"]);
    });

    test('License', () async {
      Completer<String> completer = Completer();
      String requestId = 'build';
      completers[requestId] = completer;
      await channel.invokeMockMethod('build', {
        "requestId": requestId,
        "request": jsonEncode({"publishingId": publishingId, "origin": origin})
      });
      await completer.future;
      completer = Completer();
      requestId = "license";
      completers[requestId] = completer;
      String? ptr = "license";
      String? terms = "lorem ipsum";
      String? titleDescription = "title test";
      String? licenseDescription = "license test";
      List uses = [{
        "usecases": [LicenseUsecaseEnum.aiTraining.value]
      }];
      List<String> tags = [TitleTagEnum.messages.value];
      await channel.invokeMockMethod('license', {
        "requestId": requestId,
        "request": jsonEncode({
          "ptr": ptr,
          "terms": terms,
          "titleDescription": titleDescription,
          "licenseDescription": licenseDescription,
          "uses": uses,
          "tags" : tags
        })
      });
      String jsonResponse = await completer.future;
      Map licenseMap = jsonDecode(jsonResponse)["license"];
      expect(ptr, licenseMap["title"]["ptr"]);
      expect(terms, licenseMap["terms"]);
      expect(titleDescription, licenseMap["title"]["description"]);
      expect(licenseDescription, licenseMap["description"]);
      expect(licenseMap["uses"][0]["usecases"][0], uses[0]["usecases"][0]);
      expect(tags[0], licenseMap["title"]["tags"][0]);
    });

    test('Guard', () async {
      Completer<String> completer = Completer();
      String requestId = 'build';
      completers[requestId] = completer;
      await channel.invokeMockMethod('build', {
        "requestId": requestId,
        "request": jsonEncode({"publishingId": publishingId, "origin": origin})
      });
      await completer.future;
      completer = Completer();
      requestId = "license";
      completers[requestId] = completer;
      String? ptr = "license";
      String? terms = "lorem ipsum";
      String? titleDescription = "title test";
      String? licenseDescription = "license test";
      List uses = [{
        "usecases": [LicenseUsecaseEnum.aiTraining.value]
      }];
      List<String> tags = [TitleTagEnum.messages.value];
      await channel.invokeMockMethod('license', {
        "requestId": requestId,
        "request": jsonEncode({
          "ptr": ptr,
          "terms": terms,
          "titleDescription": titleDescription,
          "licenseDescription": licenseDescription,
          "uses": uses,
          "tags" : tags
        })
      });
      String jsonResponse = await completer.future;
      Map licenseMap = jsonDecode(jsonResponse)["license"];
      expect(ptr, licenseMap["title"]["ptr"]);
      completer = Completer();
      completers["guard"] = completer;
      await channel.invokeMockMethod('guard', {
        "requestId": "guard",
        "request": jsonEncode({
          "ptr": ptr,
          "usecases": uses
        })
      });
      jsonResponse = await completer.future;
      expect(jsonDecode(jsonResponse)["success"], true);
    });
  });
}

extension MethodChannelMock on MethodChannel {
  Future<void> invokeMockMethod(String method, dynamic arguments) async {
    const codec = StandardMethodCodec();
    final data = codec.encodeMethodCall(MethodCall(method, arguments));

    return await ServicesBinding.instance.defaultBinaryMessenger
        .handlePlatformMessage(
      name,
      data,
      (ByteData? data) {},
    );
  }
}
