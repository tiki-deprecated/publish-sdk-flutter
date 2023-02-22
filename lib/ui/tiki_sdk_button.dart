/// {@category UI}
import 'package:flutter/widgets.dart';

/// The button used in Tiki SDK UIs.
///
/// In the default constructor, the button has a white background, the text color
/// is the [primaryColor] and the border color is the [accentColor].
/// In the [TikiSdkButton.color] constructor, the background and border colors are
/// the [accentColor] and the text color is white.
/// The font can be customized. The default is `SpaceGrotesk`
class TikiSdkButton extends StatelessWidget {

  /// The text of the button.
  final String text;

  /// The callback function for button tap.
  final Function callback;

  /// The font family of the button's text from pubspec. Default is `SpaceGrotesk`
  final String font;

  /// The button's background color.
  final Color backgroundColor;

  /// The button's border color.
  final Color borderColor;

  /// The button's text color.
  final Color textColor;

  /// The default constructor.
  ///
  /// The parameters are the button's [text] and its on tap [callback].
  /// The background color is white, the text color is the [primaryColor]
  /// and the border color is the [accentColor]. The [font] can be customized,
  /// default is `SpaceGrotesk`
  const TikiSdkButton(this.text, this.callback, primaryColor,
      accentColor, {
        super.key, this.font = "SpaceGrotesk"})
      :
        borderColor = accentColor,
        textColor = primaryColor,
        backgroundColor = const Color(0x00FFFFFF);

  /// The constructor for a collored button.
  ///
  /// The parameters are the button's [text] and its on tap [callback].
  /// The background color and the border color is the [accentColor]. The text
  /// color is white. The [font] can be customized,vdefault is `SpaceGrotesk`.
  const TikiSdkButton.color(this.text, this.callback, accentColor,
      {super.key, this.font = "SpaceGrotesk"})
      :
        backgroundColor = accentColor,
        borderColor = accentColor,
        textColor = const Color(0x00FFFFFF);

  @override
  Widget build(BuildContext context) {
    // TODO: https://github.com/tiki/tiki-sdk-flutter/issues/201
    throw UnimplementedError();
  }
}