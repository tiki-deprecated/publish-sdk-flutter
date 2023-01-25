import 'package:example_app/try_it_out/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../consent/service.dart';
import '../destination/service.dart';
import '../ownership/service.dart';
import '../requests/service.dart';
import '../wallet/service.dart';
import 'layout.dart';

class TryItOutPresenter {
  TryItOutService service;

  TryItOutPresenter(this.service);

  Widget tryItOut() {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<WalletService>.value(
              value: service.walletService),
          ChangeNotifierProvider<DestinationService>.value(
              value: service.destinationService),
          ChangeNotifierProvider<OwnershipService>.value(
              value: service.ownershipService),
          ChangeNotifierProvider<ConsentService>.value(
              value: service.consentService),
          ChangeNotifierProvider<RequestsService>.value(
              value: service.requestsService),
        ], child: const TryItOutLayout());
  }
}