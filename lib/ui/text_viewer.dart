/// {@category UI}
import 'package:flutter/cupertino.dart';

/// A MarkDown text viewer with optional callback button.
class TextViewer extends StatelessWidget {
  /// The color that will be used in the color Button.
  final Color accentColor;

  /// The text color.
  final Color primaryColor;

  /// The color used in background and in color Button text.
  final Color backgroundColor;

  /// The text to be shown in the viewer.
  final String text;

  /// The fontFamily from pubspec.
  final String font;

  /// The button text.
  final String buttonText;

  /// The callback function to the button tap.
  ///
  /// If null, the button will not be shown.
  final Function? callback;

  /// Default constructor for TextViewer
  ///
  /// The TextViewer is fully customizable using this constructor
  ///
  /// Parameters:
  /// - accentColor: The color that will be used in the Color Button. Default #24956A.
  /// - primaryColor: The text color. Default #2D2D2D
  /// - backgroundColor: default #FFFFFF
  /// - font: the fontFamily from pubspec. Default "SpaceGrotesk"
  const TextViewer(this.text,
      {super.key,
      this.callback,
      this.buttonText = "I agree",
      this.accentColor = const Color(0x0024956a),
      this.primaryColor = const Color(0x002D2D2D),
      this.backgroundColor = const Color(0x00ffffff),
      this.font = "SpaceGrotesk"});

  @override
  Widget build(BuildContext context) {
    // TODO:https://github.com/tiki/tiki-sdk-flutter/issues/203
    throw UnimplementedError();
  }
}
