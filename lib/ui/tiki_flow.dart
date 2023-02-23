import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/ui/offer_sheet.dart';

import 'offer.dart';
import 'offer_item.dart';

class TikiFlow{
  
  Offer offer = Offer(
      "Trade your IDFA (kind of like a serial # for your phone) for a discount.",
      Image.asset("lib/ui/assets/images/offer_sample.png", package: "tiki_sdk_flutter"),
    [
      OfferItem("Learn how our ads perform", true),
      OfferItem("Reach you on other platforms", false),
      OfferItem("Sold to other companies", false)
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