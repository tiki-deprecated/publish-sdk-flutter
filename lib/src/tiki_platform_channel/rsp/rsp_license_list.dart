import 'dart:convert';

import 'package:tiki_sdk_dart/cache/license/license_use.dart';
import 'package:tiki_sdk_dart/cache/license/license_usecase.dart';
import 'package:tiki_sdk_dart/license_record.dart';

import 'rsp.dart';

class RspLicenseList extends Rsp {
  final List<LicenseRecord> licenseList;
  final String? requestId;

  RspLicenseList({this.licenseList = const [], this.requestId});

  @override
  String toJson() => jsonEncode({
        "license": jsonEncondeLicenseList(licenseList),
        "request_id": requestId
      });

  String? jsonEncondeLicenseList(List<LicenseRecord> licenseList) {
    if (licenseList.isEmpty) return "[]";
    List<Map> returnList = [];
    for (LicenseRecord license in licenseList) {
      Map licenseMap = {
        "id": license.id,
        "title": {
          "ptr": license.title.ptr,
          "description": license.title.description,
          "tags": license.title.tags
              .map<String>((titletag) => titletag.value)
              .toList(),
          "origin": license.title.origin
        },
        "uses":
            license.uses.map<Map<String, List<String>>>((LicenseUse use) => {
                  "usecases": use.usecases
                      .map<String>((LicenseUsecase usecase) => usecase.value)
                      .toList(),
                  "destinations": use.destinations ?? []
                }),
        "terms": license.terms,
        "description": license.description,
        "expiry": license.expiry?.millisecondsSinceEpoch
      };
      returnList.add(licenseMap);
    }
    return jsonEncode(returnList);
  }
}
