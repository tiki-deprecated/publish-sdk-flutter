import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tiki_sdk_flutter/src/tiki_platform_channel/tiki_platform_channel.dart';
import 'package:uuid/uuid.dart';

import 'tiki_credentials.dart' as credentials;

void main() {
  String publishingId = credentials.publishingId;
  String id = Uuid().v4();
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
        "request": jsonEncode({"id": id, "publishingId": publishingId, "origin": origin})
      });
      String jsonResponse = await completer.future;
      expect(jsonDecode(jsonResponse)["address"].length > 32, true);
    });

    // test('License', () async {
    //   Completer<String> completer = Completer();
    //   String requestId = 'build';
    //   completers[requestId] = completer;
    //   await channel.invokeMockMethod('build', {
    //     "requestId": requestId,
    //     "request": jsonEncode({"publishingId": publishingId, "origin": origin})
    //   });
    //   await completer.future;
    //   completer = Completer();
    //   requestId = "license";
    //   completers[requestId] = completer;
    //   String? ptr = "license";
    //   String? terms = "lorem ipsum";
    //   String? titleDescription = "title test";
    //   String? licenseDescription = "license test";
    //   List tags = [{"titleTagEnum":"advertising_data"}];
    //   List uses = [{"usecases": [{"usecaseEnum":"support"}]}];
    //   await channel.invokeMockMethod('license', {
    //     "requestId": requestId,
    //     "request": jsonEncode({
    //       "terms":terms,
    //       "tags":tags,
    //       "uses":uses,
    //       "ptr":ptr,
    //       "licenseDescription":licenseDescription,
    //       "titleDescription": titleDescription})
    //   });
    //   String jsonResponse = await completer.future;
    //   Map licenseMap = jsonDecode(jsonResponse)["license"];
    //   expect(licenseMap["title"]["ptr"], ptr);
    //   expect(licenseMap["terms"], terms);
    //   expect(licenseMap["title"]["description"], titleDescription);
    //   expect(licenseMap["description"], licenseDescription);
    //   expect(licenseMap["uses"][0]["usecases"][0], uses[0]["usecases"][0]);
    //   expect(licenseMap["title"]["tags"][0], tags[0]);
    // });

  //   test('Guard', () async {
  //     Completer<String> completer = Completer();
  //     String requestId = 'build';
  //     completers[requestId] = completer;
  //     await channel.invokeMockMethod('build', {
  //       "requestId": requestId,
  //       "request": jsonEncode({"publishingId": publishingId, "origin": origin})
  //     });
  //     await completer.future;
  //     completer = Completer();
  //     requestId = "license";
  //     completers[requestId] = completer;
  //     String? ptr = "license";
  //     List uses = [{"usecases": [{"usecaseEnum":"support"}]}];
  //     await channel.invokeMockMethod('license', {
  //       "requestId": requestId,
  //       "request": jsonEncode({
  //         "request": jsonEncode({
  //           "terms":"path\/terms.md",
  //           "tags":[{"titleTagEnum":"advertising_data"}],
  //           "uses":[{"usecases":[{"usecaseEnum":"support"}]}],
  //           "ptr": ptr,
  //           "licenseDescription":"testing"})
  //       })
  //     });
  //     await completer.future;
  //     completer = Completer();
  //     requestId = "guard";
  //     completers[requestId] = completer;
  //     await channel.invokeMockMethod('guard', {
  //       "requestId": requestId,
  //       "request": jsonEncode({"source": ptr, "usecases": [{"usecaseEnum":"support"}]})
  //     });
  //     String jsonResponse = await completer.future;
  //     expect(jsonDecode(jsonResponse)["success"], true);
  //   });
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
