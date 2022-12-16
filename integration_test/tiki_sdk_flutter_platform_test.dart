import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tiki_sdk_flutter/main.dart';
import 'package:tiki_sdk_flutter/src/tiki_platform_channel/tiki_platform_channel.dart';

void main() {
  const String apiId = '2b8de004-cbe0-4bd5-bda6-b266d54f5c90';
  const String origin = 'com.mytiki.test';

  Map<String, Function(MethodCall)> callbacks = {};

  handler(MethodCall methodCall) async {
    Function(MethodCall)? callback =
        callbacks[methodCall.arguments["requestId"]];
    if (callback != null) await callback(methodCall);
  }

  TestWidgetsFlutterBinding.ensureInitialized();
  TikiPlatformChannel platform = TikiPlatformChannel();
  MethodChannel channel = platform.methodChannel;

  TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, handler);

  group('TikiSdkFlutterPlatform tests', () {
    test('Build Sdk', () async {
      bool ok = false;
      String requestId = 'build';
      callbacks[requestId] =
          (methodCall) => ok = methodCall.method == "success";
      await channel.invokeMockMethod(
          'build', {"requestId": requestId, "apiId": apiId, "origin": origin});
      expect(ok, true);
    });

    test('Assign Ownership', () async {
      bool ok = false;
      String requestId = 'assignOwnership';
      callbacks[requestId] =
          (methodCall) => ok = methodCall.method == "success";
      await channel.invokeMockMethod(
          'build', {"requestId": "build", "apiId": apiId, "origin": origin});
      await channel.invokeMockMethod('assignOwnership', {
        "requestId": requestId,
        "source": "assing test",
        "type": "data_point",
        "contains": ["nothing"],
        "origin": origin
      });
      expect(ok, true);
    });

    test('Get consent', () async {
      String requestId = 'assignOwnership';
      await channel.invokeMockMethod(
          'build', {"requestId": "build", "apiId": apiId, "origin": origin});
      callbacks[requestId] = (methodCall) async {
        callbacks.remove(requestId);
        if (methodCall.method != "success") {
          fail(methodCall.arguments["response"]);
        }
        String modifyID = "modifyConsent";
        String ownershipId = methodCall.arguments["response"];
        callbacks[modifyID] = (methodCall2) async {
          if (methodCall2.method != "success") {
            fail(methodCall2.arguments["response"]);
          }
          String getId = "getConsent";
          callbacks[getId] = (methodCall3) async {
            if (methodCall3.method != "success") {
              fail(methodCall3.arguments["response"]);
            }
          };
          await channel.invokeMockMethod('getConsent', {
            "requestId": getId,
            "source": "get consent test",
            "origin": origin
          });
        };
        await channel.invokeMockMethod('modifyConsent', {
          "requestId": modifyID,
          'ownershipId': ownershipId,
          'destination': const TikiSdkDestination.all().toJson()
        });
      };
      await channel.invokeMockMethod('assignOwnership', {
        "requestId": requestId,
        "source": "get consent test",
        "type": "data_point",
        "contains": ["nothing"],
        "origin": origin
      });
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
