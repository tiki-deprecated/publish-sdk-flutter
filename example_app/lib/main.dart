import 'package:example_app/destination/layout_btn.dart';
import 'package:example_app/requests/layout_list.dart';
import 'package:example_app/requests/service.dart';
import 'package:example_app/wallet/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'destination/layout_body_btn.dart';
import 'destination/service.dart';

void main() async {
  WalletService walletService = WalletService();
  RequestsService requestsService = RequestsService();
  DestinationService destinationService = DestinationService();
  await walletService.loadTikiSdk();
  runApp(MyApp(walletService, requestsService, destinationService));
}

class MyApp extends StatelessWidget {
  final WalletService walletService;
  final RequestsService requestsService;
  final DestinationService destinationService;

  const MyApp(this.walletService, this.requestsService, this.destinationService, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DestinationService destinationService = DestinationService();
    return MaterialApp(
        title: 'TIKI SDK Example App',
        home: Scaffold(
            body: Center(
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider<WalletService>.value(value: walletService ),
                    ChangeNotifierProvider<RequestsService>.value(value: requestsService),
                    ChangeNotifierProvider<DestinationService>.value(value: destinationService),
                  ], child: const RequestsLayoutList()))));
  }
}
