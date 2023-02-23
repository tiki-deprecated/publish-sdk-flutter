/// {@category UI}
import 'package:flutter/widgets.dart';

import 'offer_item.dart';

/// The definition of the offer for data usage.
class Offer {
  /// A description of the data usage.
  ///
  /// It will occupy 3 lines maximum in the UI. An ellipsis will be added on overflow.
  /// Accepts basic markdown styles: underline, bold and italic.
  final String description;

  /// A image description of the data usage.
  ///
  /// Use a 320x100px image.
  final Image image;

  /// The list of items that describes what can be done with the user data.
  ///
  /// Maximum 3 items.
  final List<OfferItem> items;

  const Offer(this.description, this.image, this.items)
      : assert(
          items.length <= 3,
          'The items list should not have more than 3 items',
        );
}
