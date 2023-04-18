/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
/// {@category UI}

/// An item that describes what can be done with the user data. Used in the
/// pre-built UI to show the 3 bullets underneath the Offer reward image.
class Bullet {
  /// Short description of the data usage.
  final String text;

  /// Whether it is used. If true a green check mark will be displayed before,
  /// the description. If false an x red mark will be displayed.
  final bool isUsed;

  Bullet(this.text, this.isUsed);
}
