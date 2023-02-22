/// {@category UI}
import 'package:flutter/cupertino.dart';

/// A dismissible bottom sheet that will be shown after the TIKI flow is complete.
class CompletionSheet extends StatelessWidget{

  /// The color that will be used in "your".
  final Color accentColor;

  /// The text color.
  final Color primaryColor;

  /// The color used in all backgrounds.
  final Color backgroundColor;

  /// The main text in the center of the bottom sheet.
  final String title;

  /// The first line of text in the footer.
  ///
  /// This text will occupy just one line. An ellipsis will be added on overflow.
  final String footerText;

  /// The text to be shown before the "settings" link.
  final String beforeLinkText;

  /// The fontFamily from pubspec.
  final String font;

  /// Default constructor for Completion Bottom Sheet
  ///
  /// The CompletionSheet is fully customizable using this constructor
  ///
  /// Parameters:
  /// - title: the main text in the center of the bottom sheet
  /// - footerText: the first line of text in the footer. One line of text.
  /// - beforeLinkText: the text to be shown before the "settings" link.
  /// - accentColor: The color that will be used in "your". Default #24956A
  /// - primaryColor: The text color. Default #2D2D2D
  /// - backgroundColor: default #FFFFFF
  /// - font: the fontFamily from pubspec. Default "SpaceGrotesk"
  const CompletionSheet(
    this.title,
    this.footerText,
    this.beforeLinkText, {super.key,
    this.accentColor = const Color(0x0024956a),
    this.primaryColor = const Color(0x002D2D2D),
    this.backgroundColor = const Color(0x00ffffff),
    this.font = "SpaceGrotesk"
  });

  /// The CompletionSheet to be shown after user denies the use of data.
  ///
  /// Parameters:
  /// - accentColor: The color that will be used in "your". Default #24956A
  /// - primaryColor: The text color. Default #2D2D2D
  /// - backgroundColor: default #FFFFFF
  /// - font: the fontFamily from pubspec. Default "SpaceGrotesk"
  const CompletionSheet.backoff({super.key,
    this.accentColor = const Color(0x0024956a),
    this.primaryColor = const Color(0x002D2D2D),
    this.backgroundColor = const Color(0x00ffffff),
    this.font = "SpaceGrotesk"
  }) :
    title = "Backing Off",
    footerText = "Your data is valuable.",
    beforeLinkText = "Opt-in anytime in" ;

  /// The CompletionSheet to be shown after user allows the use of data.
  ///
  /// Parameters:
  /// - accentColor: The color that will be used in "your". Default #24956A
  /// - primaryColor: The text color. Default #2D2D2D
  /// - backgroundColor: default #FFFFFF
  /// - font: the fontFamily from pubspec. Default "SpaceGrotesk"
  const CompletionSheet.awesome({super.key,
    this.accentColor = const Color(0x0024956a),
    this.primaryColor = const Color(0x002D2D2D),
    this.backgroundColor = const Color(0x00ffffff),
    this.font = "SpaceGrotesk"
  }) :
    title = "Awesome! You’re in",
    footerText = "We’re on it, stay tuned.",
    beforeLinkText = "Change your mind anytime in" ;

  @override
  Widget build(BuildContext context) {
    // TODO: https://github.com/tiki/tiki-sdk-flutter/issues/204
    throw UnimplementedError();
  }

}