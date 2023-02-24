import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiki_sdk_dart/tiki_sdk.dart';
import 'package:tiki_sdk_flutter/src/tiki_platform_channel/tiki_platform_channel.dart';
import 'tiki_credentials.dart' as credentials;

void main() {
  String publishingId = credentials.publishingId;
  const String origin = 'com.mytiki.test';
  const List<String> uses = ["Hello", "World"];
  const List<String> paths = ["path1", "path2"];

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

    test('Assign Ownership', () async {
      Completer<String> completer = Completer();
      String requestId = 'build';
      completers[requestId] = completer;
      await channel.invokeMockMethod('build', {
        "requestId": requestId,
        "request": jsonEncode({"publishingId": publishingId, "origin": origin})
      });
      await completer.future;
      completer = Completer();
      requestId = "assign";
      String source = "assign test";
      String type = TikiSdkDataTypeEnum.point.val;
      List<String> contains = ["test"];
      String about = "test about";
      completers[requestId] = completer;
      await channel.invokeMockMethod('assignOwnership', {
        "requestId": requestId,
        "request": jsonEncode({
          "source": source,
          "type": type,
          "contains": contains,
          "about": about,
          "origin": origin,
        })
      });
      String jsonResponse = await completer.future;
      Map ownershipMap = jsonDecode(jsonResponse)["ownership"];
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
      await channel.invokeMockMethod('build', {
        "requestId": requestId,
        "request": jsonEncode({"publishingId": publishingId, "origin": origin})
      });
      await completer.future;
      completer = Completer();
      requestId = "assign";
      String source = "assign test";
      String type = TikiSdkDataTypeEnum.point.val;
      List<String> contains = ["test"];
      String about = "test about";
      completers[requestId] = completer;
      await channel.invokeMockMethod('assignOwnership', {
        "requestId": requestId,
        "request": jsonEncode({
          "source": source,
          "type": type,
          "contains": contains,
          "about": about,
        })
      });
      String jsonResponse = await completer.future;
      Map ownershipMap = jsonDecode(jsonResponse)["ownership"];

      completer = Completer();
      completers["getOwnership"] = completer;
      await channel.invokeMockMethod('getOwnership', {
        "requestId": "getOwnership",
        "request": jsonEncode({"source": source})
      });
      jsonResponse = await completer.future;

      Map gotOwnership = jsonDecode(jsonResponse)["ownership"];
      expect(gotOwnership["source"], ownershipMap["source"]);
      expect(gotOwnership["type"], ownershipMap["type"]);
      expect(gotOwnership["contains"], ownershipMap["contains"]);
      expect(gotOwnership["about"], ownershipMap["about"]);
      expect(gotOwnership["origin"], ownershipMap["origin"]);
    });

    test('Get non-existing ownership', () async {
      Completer<String> completer = Completer();
      String requestId = 'build';
      completers[requestId] = completer;
      await channel.invokeMockMethod('build', {
        "requestId": requestId,
        "request": jsonEncode({"publishingId": publishingId, "origin": origin})
      });
      await completer.future;
      completer = Completer();
      completers["getOwnership"] = completer;
      await channel.invokeMockMethod('getOwnership', {
        "requestId": "getOwnership",
        "request": jsonEncode({"source": "not"})
      });
      String jsonResponse = await completer.future;
      Map? gotOwnership = jsonDecode(jsonResponse)["ownership"];
      expect(gotOwnership == null, true);
    });

    test('Modify Consent', () async {
      Completer<String> completer = Completer();
      String requestId = 'build';
      completers[requestId] = completer;
      await channel.invokeMockMethod('build', {
        "requestId": requestId,
        "request": jsonEncode({"publishingId": publishingId, "origin": origin})
      });
      await completer.future;
      completer = Completer();
      requestId = "assign";
      String source = "assign test";
      String type = TikiSdkDataTypeEnum.point.val;
      List<String> contains = ["test"];
      String about = "test about";
      completers[requestId] = completer;
      await channel.invokeMockMethod('assignOwnership', {
        "requestId": requestId,
        "request": jsonEncode({
          "source": source,
          "type": type,
          "contains": contains,
          "about": about,
          "origin": origin,
        })
      });
      String jsonResponse = await completer.future;
      Map ownershipMap = jsonDecode(jsonResponse)["ownership"];

      completer = Completer();
      completers["modify"] = completer;
      String ownershipId = ownershipMap["transactionId"];

      Map destination = const TikiSdkDestination(paths, uses: uses).toMap();
      await channel.invokeMockMethod('modifyConsent', {
        "requestId": "modify",
        "request":
            jsonEncode({"ownershipId": ownershipId, "destination": destination})
      });
      jsonResponse = await completer.future;
      Map consentMap = jsonDecode(jsonResponse)["consent"];
      expect(consentMap["ownershipId"], ownershipId);
      expect(consentMap["destination"], destination);
    });

    test('Get Consent', () async {
      Completer<String> completer = Completer();
      String requestId = 'build';
      completers[requestId] = completer;
      await channel.invokeMockMethod('build', {
        "requestId": requestId,
        "request": jsonEncode({"publishingId": publishingId, "origin": origin})
      });
      await completer.future;
      completer = Completer();
      requestId = "assign";
      String source = "assign test";
      String type = TikiSdkDataTypeEnum.point.val;
      List<String> contains = ["test"];
      String about = "test about";
      completers[requestId] = completer;
      await channel.invokeMockMethod('assignOwnership', {
        "requestId": requestId,
        "request": jsonEncode({
          "source": source,
          "type": type,
          "contains": contains,
          "about": about,
          "origin": origin,
        })
      });
      String jsonResponse = await completer.future;
      Map ownershipMap = jsonDecode(jsonResponse)["ownership"];

      completer = Completer();
      completers["modify"] = completer;
      String ownershipId = ownershipMap["transactionId"];

      Map destination = const TikiSdkDestination(paths, uses: uses).toMap();
      await channel.invokeMockMethod('modifyConsent', {
        "requestId": "modify",
        "request":
            jsonEncode({"ownershipId": ownershipId, "destination": destination})
      });
      await completer.future;

      completer = Completer();
      completers["get"] = completer;

      await channel.invokeMockMethod('getConsent', {
        "requestId": "get",
        "request": jsonEncode({"source": source})
      });

      jsonResponse = await completer.future;
      expect(
          jsonDecode(jsonResponse)["consent"]?["destination"]["paths"], paths);
      expect(jsonDecode(jsonResponse)["consent"]?["destination"]["uses"], uses);
    });

    /// this
    test('Apply Consent', () async {
      Completer<String> completer = Completer();
      String requestId = 'build';
      completers[requestId] = completer;
      await channel.invokeMockMethod('build', {
        "requestId": requestId,
        "request": jsonEncode({"publishingId": publishingId, "origin": origin})
      });
      await completer.future;
      completer = Completer();
      requestId = "assign";
      String source = "assign test";
      String type = TikiSdkDataTypeEnum.point.val;
      List<String> contains = ["test"];
      String about = "test about";
      completers[requestId] = completer;
      await channel.invokeMockMethod('assignOwnership', {
        "requestId": requestId,
        "request": jsonEncode({
          "source": source,
          "type": type,
          "contains": contains,
          "about": about,
          "origin": origin,
        })
      });
      String jsonResponse = await completer.future;
      Map ownershipMap = jsonDecode(jsonResponse)["ownership"];

      completer = Completer();
      completers["modify"] = completer;
      String ownershipId = ownershipMap["transactionId"];

      /// this
      Map destination = const TikiSdkDestination(paths, uses: uses).toMap();
      await channel.invokeMockMethod('modifyConsent', {
        "requestId": "modify",
        "request":
            jsonEncode({"ownershipId": ownershipId, "destination": destination})
      });
      await completer.future;

      completer = Completer();
      completers["apply"] = completer;

      await channel.invokeMockMethod('applyConsent', {
        "requestId": "apply",
        "request": jsonEncode({"source": source, "destination": destination})
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
