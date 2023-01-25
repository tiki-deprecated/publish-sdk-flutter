import 'package:example_app/destination/controller.dart';
import 'package:flutter/material.dart';

import 'model.dart';

class DestinationService extends ChangeNotifier {
  DestinationModel model = DestinationModel();
  DestinationController controller = DestinationController();

  void updateDestination(DestinationModel destination) {
    model = destination;
    notifyListeners();
  }
}
