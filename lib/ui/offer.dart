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

  const Offer({super.key, required this.image, required this.description, required this.bullets, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(children:[
      OfferCard(image, description),
      UsedFor(bullets, textColor),
    ]);
  }
}
