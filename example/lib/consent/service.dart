import 'dart:typed_data';

import 'package:example/consent/controller.dart';
import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/main.dart';

import '../destination/model.dart';
import 'model.dart';

class ConsentService extends ChangeNotifier {
  ConsentExampleModel model = ConsentExampleModel();
  ConsentController controller = ConsentController();

  Future<void> getOrModifyConsent(bool allow, Uint8List ownershipId,
      DestinationModel destinationModel, TikiSdk tikiSdk) async {
    TikiSdkDestination destination = TikiSdkDestination([destinationModel.url],
        uses: [destinationModel.httpMethod]);
    tikiSdk.applyConsent(destinationModel.source, destination, () async {
      ConsentModel consent = tikiSdk.getConsent(destinationModel.source)!;
      if (!allow) {
        await tikiSdk.modifyConsent(Bytes.base64UrlEncode(ownershipId),
            const TikiSdkDestination.none());
      }
      model.consent = consent;
      model.isConsentGiven = allow;
      notifyListeners();
    }, onBlocked: (String reason) async {
      ConsentModel? consent = tikiSdk.getConsent(destinationModel.source);
      if (consent == null) {
        consent = await tikiSdk.modifyConsent(
            Bytes.base64UrlEncode(ownershipId),
            allow ? destination : const TikiSdkDestination.none());
      } else if (allow) {
        consent = await tikiSdk.modifyConsent(
            Bytes.base64UrlEncode(ownershipId), destination);
      }
      model.consent = consent;
      model.isConsentGiven = allow;
      notifyListeners();
    });
  }
}
