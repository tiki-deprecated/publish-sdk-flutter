import 'package:example_app/ownership/layout_detail.dart';
import 'package:example_app/ownership/service.dart';
import 'package:example_app/wallet/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiki_sdk_flutter/main.dart';

class OwnershipLayoutBtn extends StatelessWidget {
  const OwnershipLayoutBtn({super.key});

  @override
  Widget build(BuildContext context) {
    OwnershipService service =
        Provider.of<OwnershipService>(context, listen: true);
    Provider.of<WalletService>(context, listen: true);
    return service.model.ownership == null
        ? Container()
        : Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1.0, color: const Color(0xFFCCCCCC)),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: GestureDetector(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Expanded(
                            child: Text(
                          "Ownership",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        Icon(Icons.keyboard_arrow_right)
                      ]),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  Text(Bytes.base64UrlEncode(
                      service.model.ownership!.transactionId!))
                ]),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider.value(
                        value: service,
                        child: const OwnershipLayoutDetail())))));
  }
}
