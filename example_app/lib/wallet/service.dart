import 'package:example_app/wallet/model.dart';
import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/main.dart';

class WalletService extends ChangeNotifier {
  WalletModel model = WalletModel();

  Future<void> loadTikiSdk([String? address]) async {
    TikiSdkFlutterBuilder builder = TikiSdkFlutterBuilder()
      ..origin(model.origin)
      ..apiId(model.apiId);
    if (address != null) builder.address(address);
    model.tikiSdk = await builder.build();
    if (address == null) model.wallets.add(model.tikiSdk!.address);
    notifyListeners();
  }
}
