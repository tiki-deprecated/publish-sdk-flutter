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

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tiki_sdk_flutter/main.dart';

import 'tiki_sdk_flutter_req_consent_apply.dart';
import 'tiki_sdk_flutter_req_build.dart';
import 'tiki_sdk_flutter_req_consent_get.dart';
import 'tiki_sdk_flutter_req_consent_modify.dart';
import 'tiki_sdk_flutter_req_ownership.dart';
import 'tiki_sdk_flutter_req_ownership_get.dart';
import 'tiki_sdk_flutter_resp.dart';
import 'tiki_sdk_flutter_resp_apply.dart';
import 'tiki_sdk_flutter_resp_build.dart';
import 'tiki_sdk_flutter_resp_consent.dart';
import 'tiki_sdk_flutter_resp_error.dart';
import 'tiki_sdk_flutter_resp_ownership.dart';

/// The definition of native platform channels
class TikiSdkFlutterPlatform {
  static late final TikiSdk _tikiSdk;

  final methodChannel = const MethodChannel('tiki_sdk_flutter');

  TikiSdkFlutterPlatform() {
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
        TikiSdkFlutterReqBuild tikiSdkFlutterReqBuild =
            TikiSdkFlutterReqBuild.fromJson(jsonReq);
        _buildSdk(tikiSdkFlutterReqBuild);
        break;
      case "assignOwnership":
        TikiSdkFlutterReqOwnership tikiSdkFlutterReqOwnership =
            TikiSdkFlutterReqOwnership.fromJson(jsonReq);
        _assignOwnership(tikiSdkFlutterReqOwnership);
        break;
      case "getOwnership":
        TikiSdkFlutterReqOwnershipGet tikiSdkFlutterReqOwnershipGet =
            TikiSdkFlutterReqOwnershipGet.fromJson(jsonReq);
        _getOwnership(tikiSdkFlutterReqOwnershipGet);
        break;
      case "modifyConsent":
        TikiSdkFlutterReqConsentModify tikiSdkFlutterReqConsentModify =
            TikiSdkFlutterReqConsentModify.fromJson(jsonReq);
        _modifyConsent(tikiSdkFlutterReqConsentModify);
        break;
      case "getConsent":
        TikiSdkFlutterReqConsentGet tikiSdkFlutterReqConsentGet =
            TikiSdkFlutterReqConsentGet.fromJson(jsonReq);
        _getConsent(tikiSdkFlutterReqConsentGet);
        break;
      case "applyConsent":
        TikiSdkFlutterReqConsentApply tikiSdkFlutterReqConsentApply =
            TikiSdkFlutterReqConsentApply.fromJson(jsonReq);
        _applyConsent(tikiSdkFlutterReqConsentApply);
        break;
      default:
        _error(TikiSdkFlutterRespError('no method',
            'no method handler for method ${call.method}', StackTrace.current));
    }
  }

  Future<void> _buildSdk(TikiSdkFlutterReqBuild req) async {
    try {
      TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder()
        ..origin(req.origin)
        ..apiId(req.apiId);
      if (req.address != null) {
        builder.address(req.address!);
      }
      _tikiSdk = await builder.build();
      TikiSdkFlutterRespBuild tikiSdkFlutterBuildResp =
          TikiSdkFlutterRespBuild(_tikiSdk);
      _success(tikiSdkFlutterBuildResp);
    } catch (e) {
      TikiSdkFlutterRespError error =
          TikiSdkFlutterRespError.fromError(e as Error, "build");
      _error(error);
    }
  }

  Future<void> _assignOwnership(TikiSdkFlutterReqOwnership req) async {
    try {
      await _tikiSdk.assignOwnership(req.source, req.type, req.contains,
          about: req.about, origin: req.origin);
      OwnershipModel ownershipModel =
          _tikiSdk.getOwnership(req.source, origin: req.origin)!;
      TikiSdkFlutterRespOwnership resp =
          TikiSdkFlutterRespOwnership(ownershipModel, req.requestId);
      _success(resp);
    } catch (e) {
      TikiSdkFlutterRespError error =
          TikiSdkFlutterRespError.fromError(e as Error, req.requestId);
      _error(error);
    }
  }

  void _getOwnership(TikiSdkFlutterReqOwnershipGet req) {
    try {
      OwnershipModel? ownershipModel =
          _tikiSdk.getOwnership(req.source, origin: req.origin);
      TikiSdkFlutterRespOwnership resp =
          TikiSdkFlutterRespOwnership(ownershipModel, req.requestId);
      _success(resp);
    } catch (e) {
      TikiSdkFlutterRespError error =
          TikiSdkFlutterRespError.fromError(e as Error, req.requestId);
      _error(error);
    }
  }

  Future<void> _modifyConsent(TikiSdkFlutterReqConsentModify req) async {
    try {
      ConsentModel consentModel = await _tikiSdk.modifyConsent(
          req.ownershipId, req.destination,
          about: req.about, reward: req.reward, expiry: req.expiry);
      TikiSdkFlutterRespConsent resp =
          TikiSdkFlutterRespConsent(consentModel, req.requestId);
      _success(resp);
    } catch (e) {
      TikiSdkFlutterRespError error =
          TikiSdkFlutterRespError.fromError(e as Error, req.requestId);
      _error(error);
    }
  }

  void _getConsent(TikiSdkFlutterReqConsentGet req) {
    try {
      ConsentModel? consentModel =
          _tikiSdk.getConsent(req.source, origin: req.origin);
      TikiSdkFlutterRespConsent resp =
          TikiSdkFlutterRespConsent(consentModel, req.requestId);
      _success(resp);
    } catch (e) {
      TikiSdkFlutterRespError error =
          TikiSdkFlutterRespError.fromError(e as Error, req.requestId);
      _error(error);
    }
  }

  void _applyConsent(TikiSdkFlutterReqConsentApply req) {
    try {
      request() {
        TikiSdkFlutterRespApply resp = TikiSdkFlutterRespApply(req.requestId);
        _success(resp);
      }

      onBlocked(String reason) {
        TikiSdkFlutterRespError error =
            TikiSdkFlutterRespError(req.requestId, reason, StackTrace.current);
        _error(error);
      }

      _tikiSdk.applyConsent(req.source, req.destination, request,
          onBlocked: onBlocked);
    } catch (e) {
      TikiSdkFlutterRespError error =
          TikiSdkFlutterRespError.fromError(e as Error, req.requestId);
      _error(error);
    }
  }

  Future<void> _success(TikiSdkFlutterResp resp) async =>
      await methodChannel.invokeMethod('success', {'response': resp.toJson()});

  Future<void> _error(TikiSdkFlutterRespError resp) async =>
      await methodChannel.invokeMethod('error', {'response': resp.toJson()});
}
