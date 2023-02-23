/// {@category UI}
import 'package:flutter/material.dart';
import 'offer.dart';

/// The card that represents an [Offer]
class OfferCard extends StatelessWidget{

  final Offer offer;

  const OfferCard({super.key, required this.offer});

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(13, 0, 0, 0),
                    offset: Offset(4, 4))
              ],
              borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: offer.image),
                  RichText(
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          text: offer.description,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              height: 1.2,
                              color: Color.fromARGB(150, 0, 0, 0),
                              fontFamily: "SpaceGrotesk",
                              package: "tiki_sdk_flutter"))),
                ],
              ))),
    );
}