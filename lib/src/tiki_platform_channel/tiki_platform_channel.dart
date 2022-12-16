/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// Native platform channels for TIKI SDK.
///
/// The Flutter Platform Channels are used to call native code from Dart and
/// vice-versa. In TIKI SDK we use it to call [TikiSdk] methods **from** native code.
/// It is **not used** in pure Flutter implementations.
library tiki_sdk_flutter_platform;

import 'package:flutter/services.dart';
import 'package:tiki_sdk_flutter/main.dart';

import 'request/consent_apply.dart';
import 'request/build.dart';
import 'request/consent_get.dart';
import 'request/consent_modify.dart';
import 'request/ownership_assign.dart';
import 'request/ownership_get.dart';
import 'response/error.dart';
import 'response/ownership.dart';
import 'tiki_platform_channel_resp.dart';
import 'response/build.dart';
import 'response/consent.dart';

/// The definition of native platform channels
class TikiPlatformChannel {
  static late final TikiSdk _tikiSdk;

  final methodChannel = const MethodChannel('tiki_sdk_flutter');

  TikiPlatformChannel() {
    methodChannel.setMethodCallHandler(methodHandler);
  }

  /// Handles the method calls from native code.
  ///
  /// When calling TIKI SDK Flutter from native code, one should pass a requestId
  /// that will identify to which request the response belongs to.
  /// All the calls are asynchronous and should be treated like this in each native
  /// platform.
  Future<void> methodHandler(MethodCall call) async {
    String jsonReq = call.arguments['request'];
    switch (call.method) {
      case "build":
        TikiPlatformChannelReqBuild tikiSdkFlutterReqBuild =
            TikiPlatformChannelReqBuild.fromJson(jsonReq);
        _buildSdk(tikiSdkFlutterReqBuild);
        break;
      case "assignOwnership":
        TikiPlatformChannelReqOwnership tikiSdkFlutterReqOwnership =
            TikiPlatformChannelReqOwnership.fromJson(jsonReq);
        _assignOwnership(tikiSdkFlutterReqOwnership);
        break;
      case "getOwnership":
        TikiPlatformChannelReqOwnershipGet tikiSdkFlutterReqOwnershipGet =
            TikiPlatformChannelReqOwnershipGet.fromJson(jsonReq);
        _getOwnership(tikiSdkFlutterReqOwnershipGet);
        break;
      case "modifyConsent":
        TikiPlatformChannelReqConsentModify tikiSdkFlutterReqConsentModify =
            TikiPlatformChannelReqConsentModify.fromJson(jsonReq);
        _modifyConsent(tikiSdkFlutterReqConsentModify);
        break;
      case "getConsent":
        TikiPlatformChannelReqConsentGet tikiSdkFlutterReqConsentGet =
            TikiPlatformChannelReqConsentGet.fromJson(jsonReq);
        _getConsent(tikiSdkFlutterReqConsentGet);
        break;
      case "applyConsent":
        TikiPlatformChannelReqConsentApply tikiSdkFlutterReqConsentApply =
            TikiPlatformChannelReqConsentApply.fromJson(jsonReq);
        _applyConsent(tikiSdkFlutterReqConsentApply);
        break;
      default:
        _error(TikiPlatformChannelRespError('no method',
            'no method handler for method ${call.method}', StackTrace.current));
    }
  }

  Future<void> _buildSdk(TikiPlatformChannelReqBuild req) async {
    try {
      TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder()
        ..origin(req.origin)
        ..apiId(req.apiId);
      if (req.address != null) {
        builder.address(req.address!);
      }
      _tikiSdk = await builder.build();
      TikiPlatformChannelRespBuild tikiSdkFlutterBuildResp =
          TikiPlatformChannelRespBuild(_tikiSdk);
      _success(tikiSdkFlutterBuildResp);
    } catch (e) {
      TikiPlatformChannelRespError error =
          TikiPlatformChannelRespError.fromError(e as Error, "build");
      _error(error);
    }
  }

  Future<void> _assignOwnership(TikiPlatformChannelReqOwnership req) async {
    try {
      await _tikiSdk.assignOwnership(req.source, req.type, req.contains,
          about: req.about, origin: req.origin);
      OwnershipModel ownershipModel =
          _tikiSdk.getOwnership(req.source, origin: req.origin)!;
      TikiPlatformChannelRespOwnership resp =
          TikiPlatformChannelRespOwnership(ownershipModel, req.requestId);
      _success(resp);
    } catch (e) {
      TikiPlatformChannelRespError error =
          TikiPlatformChannelRespError.fromError(e as Error, req.requestId);
      _error(error);
    }
  }

  void _getOwnership(TikiPlatformChannelReqOwnershipGet req) {
    try {
      OwnershipModel? ownershipModel =
          _tikiSdk.getOwnership(req.source, origin: req.origin);
      TikiPlatformChannelRespOwnership resp =
          TikiPlatformChannelRespOwnership(ownershipModel, req.requestId);
      _success(resp);
    } catch (e) {
      TikiPlatformChannelRespError error =
          TikiPlatformChannelRespError.fromError(e as Error, req.requestId);
      _error(error);
    }
  }

  Future<void> _modifyConsent(TikiPlatformChannelReqConsentModify req) async {
    try {
      ConsentModel consentModel = await _tikiSdk.modifyConsent(
          req.ownershipId, req.destination,
          about: req.about, reward: req.reward, expiry: req.expiry);
      TikiPlatformChannelRespConsent resp =
          TikiPlatformChannelRespConsent(consentModel, req.requestId);
      _success(resp);
    } catch (e) {
      TikiPlatformChannelRespError error =
          TikiPlatformChannelRespError.fromError(e as Error, req.requestId);
      _error(error);
    }
  }

  void _getConsent(TikiPlatformChannelReqConsentGet req) {
    try {
      ConsentModel? consentModel =
          _tikiSdk.getConsent(req.source, origin: req.origin);
      TikiPlatformChannelRespConsent resp =
          TikiPlatformChannelRespConsent(consentModel, req.requestId);
      _success(resp);
    } catch (e) {
      TikiPlatformChannelRespError error =
          TikiPlatformChannelRespError.fromError(e as Error, req.requestId);
      _error(error);
    }
  }

  void _applyConsent(TikiPlatformChannelReqConsentApply req) {
    try {
      request() {
        TikiPlatformChannelResp resp = TikiPlatformChannelResp(req.requestId);
        resp.requestId = req.requestId;
        _success(resp);
      }

      onBlocked(String reason) {
        TikiPlatformChannelRespError error =
            TikiPlatformChannelRespError(req.requestId, reason, StackTrace.current);
        _error(error);
      }

      _tikiSdk.applyConsent(req.source, req.destination, request,
          onBlocked: onBlocked);
    } catch (e) {
      TikiPlatformChannelRespError error =
          TikiPlatformChannelRespError.fromError(e as Error, req.requestId);
      _error(error);
    }
  }

  Future<void> _success(TikiPlatformChannelResp resp) async =>
      await methodChannel.invokeMethod('success', {'response': resp.toJson()});

  Future<void> _error(TikiPlatformChannelRespError resp) async =>
      await methodChannel.invokeMethod('error', {'response': resp.toJson()});
}
