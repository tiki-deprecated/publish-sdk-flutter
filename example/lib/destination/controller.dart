import 'package:example/destination/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class DestinationController {
  updateDestination(DestinationModel destination, BuildContext context) {
    Provider.of<DestinationService>(context, listen: false)
        .updateDestination(destination);
  }
}
