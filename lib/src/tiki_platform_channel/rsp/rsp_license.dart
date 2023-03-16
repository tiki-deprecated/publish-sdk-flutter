import 'dart:convert';

import 'package:tiki_sdk_dart/cache/license/license_use.dart';
import 'package:tiki_sdk_dart/cache/license/license_usecase.dart';
import 'package:tiki_sdk_dart/license_record.dart';

import 'rsp.dart';

class RspLicense extends Rsp {
  final LicenseRecord? license;
  final String? requestId;

  RspLicense({this.license, this.requestId});

  @override
  String toJson() =>
      jsonEncode({"license": mapLicense(license), "request_id": requestId});

  Map? mapLicense(LicenseRecord? license) {
    if (license == null) return null;
    Map licenseMap = {
      "id": license.id,
      "title": {
        "id": license.title.id,
        "ptr": license.title,
        "description": license.title.description,
        "tags": license.title.tags
            .map<Map<String, String>>(
                (titleTag) => {"titleTagEnum": titleTag.value})
            .toList(),
        "origin": license.title.origin
      },
      "uses": license.uses
          .map<Map<String, List>>((LicenseUse use) => {
                "usecases": use.usecases
                    .map<Map<String, String>>((LicenseUsecase usecase) =>
                        {"usecaseEnum": usecase.value})
                    .toList(),
                "destinations": use.destinations ?? []
              })
          .toList(),
      "terms": license.terms,
      "description": license.description,
      "expiry": license.expiry?.millisecondsSinceEpoch
    };
    return licenseMap;
  }
}
