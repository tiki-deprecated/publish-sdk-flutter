import 'package:flutter/material.dart';

import 'wallet_list.dart';

class WalletCard extends StatelessWidget {
  final String currentWallet;
  final List<String> wallets;

  const WalletCard(this.wallets, this.currentWallet, {super.key});

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
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => WalletList(wallets, currentWallet)))));
  }
}
