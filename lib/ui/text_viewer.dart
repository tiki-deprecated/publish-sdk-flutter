/// {@category UI}
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'assets/icons/tiki_sdk_icons_icons.dart';
import 'button.dart';

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

  final String title;

  /// Default constructor for TextViewer
  ///
  /// The TextViewer is fully customizable using this constructor
  ///
  /// Parameters:
  /// - accentColor: The color that will be used in the Color Button. Default #24956A.
  /// - primaryColor: The text color. Default #2D2D2D
  /// - backgroundColor: default #FFFFFF
  /// - font: the fontFamily from pubspec. Default "SpaceGrotesk"
  const TextViewer(this.text, this.title,
      {super.key,
      this.callback,
      this.buttonText = "I agree",
      this.accentColor = const Color(0x0024956a),
      this.primaryColor = const Color(0x002D2D2D),
      this.backgroundColor = const Color(0x00ffffff),
      this.font = "SpaceGrotesk"});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'TIKI SDK Example App',
    home: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop() ),
          title: Text(title),
          actions: [
            IconButton(icon: const Icon(TikiSdkIcons.icon_circle_question,
                color: Color.fromARGB(153, 0, 0, 0)), onPressed: () => "Learnmore"
            )
          ],
        ),
        body: SafeArea(child:
          Column(
            children: [
              Expanded(child: FutureBuilder(
              future: DefaultAssetBundle.of(context).loadString('assets/data/text.md'),
                builder: (context, snapshot) {
                  return Markdown(data: snapshot.data!);
                    }
                ),
            ),
            if(callback != null) Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 50, left:15, right:15),
              child: Button.solid(buttonText, callback!, accentColor))
            ])
        )));
}
