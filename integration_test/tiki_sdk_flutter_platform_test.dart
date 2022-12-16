import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiki_sdk_dart/tiki_sdk.dart';
import 'package:tiki_sdk_flutter/src/tiki_platform_channel/tiki_platform_channel.dart';

void main() {
  const String apiId = '2b8de004-cbe0-4bd5-bda6-b266d54f5c90';
  const String origin = 'com.mytiki.test';

  Map<String, Completer<String>> completers = {};

  handler(MethodCall methodCall) async {
    String jsonResponse = methodCall.arguments["response"];
    Completer<String>? completer = completers[jsonDecode(jsonResponse)["requestId"]];
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
      await channel.invokeMockMethod(
          'build', {"request": jsonEncode({"requestId": requestId, "apiId": apiId, "origin": origin})});
      String jsonResponse = await completer.future;
      expect(jsonDecode(jsonResponse)["requestId"], requestId);
      expect(jsonDecode(jsonResponse)["address"].length > 32, true);
    });

    test('Build Sdk - providing address', () async {
      Completer<String> completer = Completer();
      String requestId = 'build';
      completers[requestId] = completer;
      await channel.invokeMockMethod(
          'build', {"request": jsonEncode({"requestId": requestId, "apiId": apiId, "origin": origin})});
      String jsonResponse = await completer.future;
      String address = jsonDecode(jsonResponse)["address"];

      completer = Completer();
      completers[requestId] = completer;
      await channel.invokeMockMethod(
          'build', {"request": jsonEncode({"requestId": requestId, "apiId": apiId, "origin": origin, "address" : address})});
      jsonResponse = await completer.future;
      expect(address, jsonDecode(jsonResponse)["address"]);
    });

    test('Assign Ownership', () async {
      Completer<String> completer = Completer();
      String requestId = 'build';
      completers[requestId] = completer;
      await channel.invokeMockMethod(
          'build', {"request": jsonEncode({"requestId": requestId, "apiId": apiId, "origin": origin})});
      await completer.future;
      completer = Completer();
      requestId = "assign";
      String source = "assign test";
      String type = TikiSdkDataTypeEnum.point.val;
      List<String> contains = ["test"];
      String about = "test about";
      completers[requestId] = completer;
      await channel.invokeMockMethod(
          'assignOwnership', {
            "request": jsonEncode(
                {"requestId": requestId,
                  "source": source,
                  "type": type,
                  "contains": contains,
                  "about": about,
                  "origin": origin,
                })});
      String jsonResponse = await completer.future;
      Map ownershipMap = jsonDecode(jsonDecode(jsonResponse)["ownership"]);
      expect(source, ownershipMap["source"]);
      expect(type, ownershipMap["type"]);
      expect(contains, ownershipMap["contains"]);
      expect(about, ownershipMap["about"]);
      expect(origin, ownershipMap["origin"]);
    });

    test('Get Ownership', () async {
      Completer<String> completer = Completer();
      String requestId = 'build';
      completers[requestId] = completer;
      await channel.invokeMockMethod(
          'build', {"request": jsonEncode({"requestId": requestId, "apiId": apiId, "origin": origin})});
      await completer.future;
      completer = Completer();
      requestId = "assign";
      String source = "assign test";
      String type = TikiSdkDataTypeEnum.point.val;
      List<String> contains = ["test"];
      String about = "test about";
      completers[requestId] = completer;
      await channel.invokeMockMethod(
          'assignOwnership', {
        "request": jsonEncode(
            {"requestId": requestId,
              "source": source,
              "type": type,
              "contains": contains,
              "about": about,
              "origin": origin,
            })});
      String jsonResponse = await completer.future;
      Map ownershipMap = jsonDecode(jsonDecode(jsonResponse)["ownership"]);

      completer = Completer();
      completers["getOwnership"] = completer;
      await channel.invokeMockMethod('getOwnership',
          {"request": jsonEncode({"requestId": "getOwnership", "source": source})});
      jsonResponse = await completer.future;

      Map gotOwnership = jsonDecode(jsonDecode(jsonResponse)["ownership"]);
      expect(gotOwnership["source"], ownershipMap["source"]);
      expect(gotOwnership["type"], ownershipMap["type"]);
      expect(gotOwnership["contains"], ownershipMap["contains"]);
      expect(gotOwnership["about"], ownershipMap["about"]);
      expect(gotOwnership["origin"], ownershipMap["origin"]);
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
