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

  List jsonEncondeLicenseList(List<LicenseRecord> licenseList) {
    if (licenseList.isEmpty) return [];
    List<Map> returnList = [];
    for (LicenseRecord license in licenseList) {
      Map licenseMap = {
        "id": license.id,
        "title": {
          "id": license.title.id,
          "ptr": license.title.hashedPtr,
          "description": license.title.description,
          "tags": license.title.tags
              .map<String>((titleTag) => titleTag.value)
              .toList(),
          "origin": license.title.origin
        },
        "uses": license.uses
            .map<Map<String, List?>>((LicenseUse use) => {
                  "usecases": use.usecases
                      .map<String>((LicenseUsecase usecase) => usecase.value)
                      .toList(),
                  "destinations": use.destinations
                })
            .toList(),
        "terms": license.terms,
        "description": license.description,
        "expiry": license.expiry?.millisecondsSinceEpoch
      };
      returnList.add(licenseMap);
    }
    return returnList;
  }
}
