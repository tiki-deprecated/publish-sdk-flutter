import 'package:example_app/consent/service.dart';
import 'package:example_app/wallet/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tiki_sdk_flutter/main.dart';

import '../destination/model.dart';
import '../destination/service.dart';
import '../ownership/service.dart';

class ConsentController {
  modifyConsent(bool allow, BuildContext context) {
    TikiSdk tikiSdk =
        Provider.of<WalletService>(context, listen: false).model.tikiSdk!;
    OwnershipModel ownership =
        Provider.of<OwnershipService>(context, listen: false).model.ownership!;
    DestinationModel destinationModel =
        Provider.of<DestinationService>(context, listen: false).model;
    Provider.of<ConsentService>(context, listen: false).getOrModifyConsent(
        allow, ownership.transactionId!, destinationModel, tikiSdk);
  }
}
