import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/ui/offer.dart';

import 'used_bullet.dart';

class Settings extends StatelessWidget{

  final Image offerImage;
  final String offerDescription;
  final List<UsedBullet> bullets;
  final Color primaryColor;
  final Color accentColor;

  const Settings({super.key, required this.offerImage, required this.offerDescription, required this.bullets, required this.primaryColor, required this.accentColor});

  @override
  Widget build(BuildContext context) => MaterialApp(
  title: 'TIKI SDK Example App',
  home: Scaffold(body: SafeArea(child:
    Column(
      children: [
        //title
        Offer(
            image: offerImage,
            description: offerDescription,
            bullets: bullets,
            textColor: primaryColor,
        ),
        // TERMS AND CONDITIONS
        // Opt in/out
    ])
  )));
}