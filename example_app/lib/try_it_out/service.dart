import 'package:flutter/widgets.dart';

import '../consent/service.dart';
import '../destination/service.dart';
import '../ownership/service.dart';
import '../requests/service.dart';
import '../wallet/service.dart';
import 'presenter.dart';

class TryItOutService extends ChangeNotifier {
  late TryItOutPresenter presenter;
  OwnershipService ownershipService = OwnershipService();
  ConsentService consentService = ConsentService();
  DestinationService destinationService = DestinationService();
  RequestsService requestsService = RequestsService();
  late WalletService walletService;

  Future<void> init() async {
    walletService = WalletService(
        ownershipService, consentService, destinationService, requestsService);
    presenter = TryItOutPresenter(this);
    await walletService.loadTikiSdk();
    notifyListeners();
  }
}
