import 'package:example_app/consent/service.dart';
import 'package:example_app/destination/service.dart';
import 'package:example_app/ownership/service.dart';
import 'package:example_app/requests/service.dart';
import 'package:example_app/wallet/model.dart';
import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/main.dart';

class WalletService extends ChangeNotifier {
  WalletModel model = WalletModel();
  OwnershipService ownershipService;
  ConsentService consentService;
  DestinationService destinationService;
  RequestsService requestsService;

  WalletService(this.ownershipService, this.consentService,
      this.destinationService, this.requestsService);

  Future<void> loadTikiSdk([String? address]) async {
    TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder()
      ..origin(model.origin)
      ..apiId(model.apiId);
    if (address != null) builder.address(address);
    model.tikiSdk = await builder.build();
    if (address == null) {
      model.wallets.add(model.tikiSdk!.address);
    }
    await ownershipService.getOrAssignOwnership(
        destinationService.model.source, model.tikiSdk!);
    await consentService.getOrModifyConsent(
        false,
        ownershipService.model.ownership!.transactionId!,
        destinationService.model,
        model.tikiSdk!);
    requestsService.stopTimer();
    requestsService.startTimer(destinationService.model, model.tikiSdk!);
    notifyListeners();
  }
}
