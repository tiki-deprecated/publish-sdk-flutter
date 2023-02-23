/// {@category UI}
import 'package:flutter/cupertino.dart';

import 'assets/icons/tiki_sdk_icons_icons.dart';
import 'offer.dart';

/// The list of [OfferItem] of the [Offer].
///
/// A `X` represents the not allowed [OfferItem] and a `V` represents an allowed one.
class OfferBullets extends StatelessWidget {
  final Offer offer;
  final Color primaryColor;

  const OfferBullets(this.offer, this.primaryColor, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "HOW YOUR DATA WILL BE USED",
                      style: TextStyle(
                          fontFamily: "SpaceGrotesk",
                          package: "tiki_sdk_flutter",
                          fontSize: 16,
                          height: 1.8,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    ),
                    ...offer.items.map((item) => Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Row(children: [
                            Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: item.allow
                                    ? const Icon(TikiSdkIcons.check_icon,
                                        color: Color.fromRGBO(0, 178, 114, 1),
                                        size: 12)
                                    : const Icon(TikiSdkIcons.x_icon,
                                        color: Color.fromRGBO(199, 48, 0, 1),
                                        size: 12)),
                            Text(
                              item.description,
                              style: const TextStyle(
                                  fontFamily: "SpaceGrotesk",
                                  package: "tiki_sdk_flutter",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(0, 0, 0, 0.6)),
                            )
                          ]),
                        ))
                  ]))
        ],
      ));
}
