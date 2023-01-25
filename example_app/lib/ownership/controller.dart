import 'package:example_app/ownership/service.dart';
import 'package:example_app/wallet/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tiki_sdk_flutter/main.dart';

import '../destination/model.dart';

class OwnershipController {
  getOrAssignOnwership(DestinationModel destination, BuildContext context) {
    TikiSdk tikiSdk = Provider.of<WalletService>(context, listen: false).model.tikiSdk!;
    Provider.of<OwnershipService>(context, listen: false)
        .getOrAssignOwnership(destination.source, tikiSdk);
  }
}
