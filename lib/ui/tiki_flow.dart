import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/ui/offer_sheet.dart';

import 'offer.dart';
import 'offer_item.dart';

class TikiFlow{
  
  Offer offer = Offer(
    "test Offer",
    Image.network("https://via.placeholder.com/320x100"),
    [
      OfferItem("test", true),
      OfferItem("no", true),
      OfferItem("no", true)
    ]
  );
  
  start(BuildContext context){
    showModalBottomSheet<dynamic>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) => OfferSheet(offer));
  }
}