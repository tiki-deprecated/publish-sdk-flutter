import 'package:example_app/wallet/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletLayoutList extends StatelessWidget {
  const WalletLayoutList({super.key});

  @override
  Widget build(BuildContext context) {
    WalletService service = Provider.of<WalletService>(context, listen: true);
    List<String> wallets = service.model.wallets;
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
                                              service.model.tikiSdk?.address
                                          ? FontWeight.bold
                                          : FontWeight.normal)),
                              leading: const Icon(Icons.keyboard_arrow_left,
                                  color: Color(0xFFD2D5D7)),
                              onTap: () {
                                if (wallet != service.model.tikiSdk?.address) {
                                  service.loadTikiSdk(wallet);
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
          service.loadTikiSdk();
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
