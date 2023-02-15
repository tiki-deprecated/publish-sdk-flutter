import 'package:flutter/material.dart';

import 'wallet_list.dart';

class WalletCard extends StatelessWidget {
  final String currentWallet;
  final List<String> wallets;
  final Future<void> Function([String? address]) loadTikiSdk;

  const WalletCard(this.wallets, this.currentWallet, this.loadTikiSdk, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1.0, color: const Color(0xFFCCCCCC)),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: GestureDetector(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(currentWallet))),
                  const Icon(Icons.keyboard_arrow_right)
                ]),
            onTap: () async {
              String wallet = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WalletList(wallets, currentWallet)));
              if(wallet != currentWallet) loadTikiSdk(wallet);
            }));
  }
}
