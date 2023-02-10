import 'package:example/requests/service.dart';
import 'package:example/wallet/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tiki_sdk_flutter/main.dart';

import '../destination/model.dart';

class RequestsController {
  startTimer(BuildContext context, DestinationModel destination) {
    TikiSdk tikiSdk =
        Provider.of<WalletService>(context, listen: false).model.tikiSdk!;
    RequestsService requestsService =
        Provider.of<RequestsService>(context, listen: false);
    requestsService.startTimer(destination, tikiSdk);
  }

  stopTimer(BuildContext context) {
    RequestsService requestsService =
        Provider.of<RequestsService>(context, listen: false);
    requestsService.stopTimer();
  }
}
