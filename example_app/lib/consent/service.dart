import 'dart:typed_data';

import 'package:example_app/consent/controller.dart';
import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/main.dart';

import '../destination/model.dart';
import 'model.dart';

class ConsentService extends ChangeNotifier {
  ConsentExampleModel model = ConsentExampleModel();
  ConsentController controller = ConsentController();

  Future<void> modifyConsent(bool allow, Uint8List ownershipId, DestinationModel destinationModel, TikiSdk tikiSdk) async {
    TikiSdkDestination destination = allow ?
      TikiSdkDestination([destinationModel.url], uses: [destinationModel.httpMethod]) :
      const TikiSdkDestination.none();
    ConsentModel consent = await tikiSdk.modifyConsent(Bytes.base64UrlEncode(ownershipId), destination);
    model.consent = consent;
    model.isConsentGiven = allow;
    notifyListeners();
  }
}
