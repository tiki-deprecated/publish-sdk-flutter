import 'package:example_app/wallet/layout_btn.dart';
import 'package:example_app/wallet/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WalletService walletService = WalletService();
    walletService.loadTikiSdk();
    return MaterialApp(
        title: 'TIKI SDK Example App',
        home: Scaffold(
            body: Center(
                child: ChangeNotifierProvider<WalletService>.value(
                    value: walletService, child: const WalletLayoutBtn()))));
  }
}
