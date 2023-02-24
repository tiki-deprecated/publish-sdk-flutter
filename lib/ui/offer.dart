/// {@category UI}
import 'package:flutter/widgets.dart';

import 'offer_card.dart';
import 'used_bullet.dart';
import 'used_for.dart';

/// The definition of the offer for data usage.
class Offer extends StatelessWidget{

  final Image image;
  final String description;
  final List<UsedBullet> bullets;
  final Color? textColor;

  final String? fontFamily;

  final String? package;

  final Color? backGroundColor;

  const Offer(this.image, this.description, this.bullets,{ super.key,
        this.textColor,
        this.fontFamily,
        this.package,
        this.backGroundColor});

  @override
  Widget build(BuildContext context) {
    return Column(children:[
      OfferCard(image, description, textColor: textColor,
          backgroundColor: backGroundColor, fontFamily: fontFamily, package: package),
      UsedFor(bullets, textColor, fontFamily: fontFamily, package: package),
    ]);
  }
}
