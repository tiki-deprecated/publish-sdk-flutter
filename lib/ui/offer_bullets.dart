/// {@category UI}
import 'package:flutter/cupertino.dart';

import 'offer.dart';

/// The list of [OfferItem] of the [Offer].
///
/// A `X` represents the not allowed [OfferItem] and a `V` represents an allowed one.
class OfferBullets extends StatelessWidget{

  final Offer offer;

  const OfferBullets(this.offer, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: https://github.com/tiki/tiki-sdk-flutter/issues/200
    throw UnimplementedError();
  }
}