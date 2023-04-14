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

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:tiki_sdk_dart/license_record.dart';
import 'package:tiki_sdk_dart/title_record.dart';

import '../../tiki_sdk.dart';
import 'req/req_guard.dart';
import 'req/req_init.dart';
import 'req/req_license.dart';
import 'req/req_license_all.dart';
import 'req/req_license_get.dart';
import 'req/req_license_latest.dart';
import 'req/req_title.dart';
import 'req/req_title_get.dart';
import 'rsp/rsp.dart';
import 'rsp/rsp_error.dart';
import 'rsp/rsp_guard.dart';
import 'rsp/rsp_init.dart';
import 'rsp/rsp_license.dart';
import 'rsp/rsp_license_list.dart';
import 'rsp/rsp_title.dart';

/// The definition of native platform channels
class PlatformChannel {
  final methodChannel = const MethodChannel('tiki_sdk_flutter');

  PlatformChannel() {
    methodChannel.setMethodCallHandler(methodHandler);
  }

  /// Handles the method calls from native code.
  ///
  /// When calling TIKI SDK Flutter from native code, one should pass a requestId
  /// that will identify to which request the response belongs to.
  /// All the calls are asynchronous and should be treated like this in each native
  /// platform.
  /// Each [call.method] has its own request object that inherits from [Req]. It
  /// should be passed in the [call.arguments] with the key `request`.
  /// The responses passed back to the native channels inherits from [Rsp] and
  /// are JSON encoded in the [call.arguments] with the key `response`.
  Future<void> methodHandler(MethodCall call) async {
    String jsonReq = call.arguments['request'];
    String requestId = call.arguments['requestId'];
    switch (call.method) {
      case "build":
        await _handle(requestId, ReqInit.fromJson(jsonReq), _init);
        break;
      case "license":
        await _handle(requestId, ReqLicense.fromJson(jsonReq), _license);
        break;
      case "latest":
        await _handle(
            requestId, ReqLicenseLatest.fromJson(jsonReq), _licenseLatest);
        break;
      case "all":
        await _handle(requestId, ReqLicenseAll.fromJson(jsonReq), _licenseAll);
        break;
      case "getLicense":
        await _handle(requestId, ReqLicenseGet.fromJson(jsonReq), _licenseGet);
        break;
      case "title":
        await _handle(requestId, ReqTitle.fromJson(jsonReq), _title);
        break;
      case "getTitle":
        await _handle(requestId, ReqTitleGet.fromJson(jsonReq), _titleGet);
        break;
      case "guard":
        await _handle(requestId, ReqGuard.fromJson(jsonReq), _guard);
        break;
      default:
        _error(
            requestId,
            RspError(
                message: 'no method handler for method ${call.method}',
                stackTrace: StackTrace.current));
    }
  }

  Future<RspInit> _init(ReqInit req) async {
    await TikiSdk.config()
        .initialize(req.publishingId, req.id, origin: req.origin);
    return RspInit(address: TikiSdk.instance.address);
  }

  Future<void> _handle<S, D extends Rsp>(
      String requestId, S req, Future<D> Function(S) process) async {
    try {
      D rsp = await process(req);
      _success(requestId, rsp);
    } catch (e) {
      RspError error = RspError.fromError(e as Error);
      await methodChannel.invokeMethod(
          'error', {'requestId': requestId, 'response': error.toJson()});
    }
  }

  Future<void> _success(String requestId, Rsp rsp) async {
    await methodChannel.invokeMethod(
        'success', {'requestId': requestId, 'response': rsp.toJson()});
  }

  Future<void> _error(String requestId, RspError rsp) async =>
      await methodChannel.invokeMethod(
          'error', {'requestId': requestId, 'response': rsp.toJson()});

  Future<RspLicense> _license(ReqLicense reqLicense) async {
    LicenseRecord licenseRecord = await TikiSdk.license(
        reqLicense.ptr!, reqLicense.uses, reqLicense.terms!,
        origin: reqLicense.origin,
        tags: reqLicense.tags,
        titleDescription: reqLicense.titleDescription,
        licenseDescription: reqLicense.licenseDescription,
        expiry: reqLicense.expiry);
    return RspLicense(license: licenseRecord);
  }

  Future<RspLicense> _licenseLatest(ReqLicenseLatest reqLicenseLatest) async {
    LicenseRecord? licenseRecord =
        TikiSdk.latest(reqLicenseLatest.ptr!, origin: reqLicenseLatest.origin);
    return RspLicense(license: licenseRecord);
  }

  Future<RspLicenseList> _licenseAll(ReqLicenseAll reqLicenseAll) async {
    List<LicenseRecord> licenses =
        TikiSdk.all(reqLicenseAll.ptr!, origin: reqLicenseAll.origin);
    return RspLicenseList(licenseList: licenses);
  }

  Future<RspLicense> _licenseGet(ReqLicenseGet reqLicenseGet) async {
    LicenseRecord? licenseRecord = TikiSdk.getLicense(reqLicenseGet.id!);
    return RspLicense(license: licenseRecord);
  }

  Future<RspTitle> _title(ReqTitle reqTitle) async {
    TitleRecord titleRecord = await TikiSdk.title(reqTitle.ptr!,
        origin: reqTitle.origin,
        description: reqTitle.description,
        tags: reqTitle.tags);
    return RspTitle(title: titleRecord);
  }

  Future<RspTitle> _titleGet(ReqTitleGet reqTitleGet) async {
    TitleRecord? titleRecord = TikiSdk.getTitle(reqTitleGet.id!);
    return RspTitle(title: titleRecord);
  }

  Future<Rsp> _guard(ReqGuard reqGuard) async {
    bool result;
    String? reason;
    result = await TikiSdk.guard(reqGuard.ptr!, reqGuard.uses,
        destinations: reqGuard.destinations,
        origin: reqGuard.origin, onFail: (reason) {
      reason = reason;
    });
    return RspGuard(success: result, reason: reason);
  }
}
