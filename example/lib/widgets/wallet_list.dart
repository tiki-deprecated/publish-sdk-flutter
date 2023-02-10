import 'package:flutter/material.dart';

class WalletList extends StatefulWidget {
  final List<String> wallets;
  final String currentWallet;

  const WalletList(this.wallets, this.currentWallet, {super.key});

  @override
  State<StatefulWidget> createState() => WalletListState();
}

class WalletListState extends State<WalletList>{
  late List<String> wallets;
  late String currentWallet;

  @override
  void initState() {
    wallets = widget.wallets;
    currentWallet = widget.currentWallet;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              color: const Color(0xFFDDDDDD),
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Wallets", style: TextStyle(fontSize: 32)),
                    ),
                    ...wallets.map((wallet) {
                      return Column(children: [
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              tileColor: Colors.white,
                              title: Text(wallet,
                                  style: TextStyle(
                                      fontWeight: wallet ==
                                              currentWallet
                                          ? FontWeight.bold
                                          : FontWeight.normal)),
                              leading: const Icon(Icons.keyboard_arrow_left,
                                  color: Color(0xFFD2D5D7)),
                              onTap: () {
                                if (wallet != currentWallet) {
                                  // TODO load wallet
                                }
                                Navigator.of(context).pop();
                              },
                            )),
                        if (wallets.indexOf(wallet) < wallets.length - 1)
                          const Divider()
                      ]);
                    })
                  ])))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO create new wallet
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}