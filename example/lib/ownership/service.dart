import 'package:example/ownership/controller.dart';
import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/main.dart';

import 'model.dart';

class OwnershipService extends ChangeNotifier {
  OwnershipExampleModel model = OwnershipExampleModel();
  OwnershipController controller = OwnershipController();

  Future<void> getOrAssignOwnership(String source, TikiSdk tikiSdk) async {
    OwnershipModel? ownership = tikiSdk.getOwnership(source);
    if (ownership != null) {
      model.ownership = ownership;
      notifyListeners();
      return;
    }
    await tikiSdk
        .assignOwnership(source, TikiSdkDataTypeEnum.stream, ["Test data"]);
    model.ownership = tikiSdk.getOwnership(source);
    notifyListeners();
  }
}
