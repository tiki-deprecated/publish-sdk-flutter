/// {@category UI}
import 'dart:ffi';

/// An item that describes what can be done with the user data.
class OfferItem{

  /// Description of the data usage.
  final String description;

  /// Whether this usage is allowed or not.
  final Bool allow;

  OfferItem(this.description, this.allow);
}