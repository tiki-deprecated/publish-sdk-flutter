import 'package:example_app/destination/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class DestinationController {
  updateDestination(DestinationModel destination, BuildContext context) {
    // get/assign onwership
    // get consent
    Provider.of<DestinationService>(context, listen: false)
        .updateDestination(destination);
  }
}
