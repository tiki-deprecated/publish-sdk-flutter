import 'package:flutter/widgets.dart';

import '../consent/service.dart';
import '../destination/service.dart';
import '../ownership/service.dart';
import '../requests/service.dart';
import '../wallet/service.dart';
import 'presenter.dart';

class TryItOutService extends ChangeNotifier{
  late TryItOutPresenter presenter;
  WalletService walletService = WalletService();
  DestinationService destinationService = DestinationService();
  OwnershipService ownershipService = OwnershipService();
  ConsentService consentService = ConsentService();
  RequestsService requestsService = RequestsService();

  Future<void> init() async {
    presenter = TryItOutPresenter(this);
    await walletService.loadTikiSdk();
    await ownershipService.getOrAssignOwnership(destinationService.model.source, walletService.model.tikiSdk!);
    await consentService.modifyConsent(
        false, ownershipService.model.ownership!.transactionId!,
        destinationService.model, walletService.model.tikiSdk!);
    notifyListeners();
  }
}