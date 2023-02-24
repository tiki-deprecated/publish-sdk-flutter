/// {@category UI}
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:tiki_sdk_flutter/ui/learn_more_btn.dart';

import 'assets/icons/tiki_sdk_icons_icons.dart';
import 'button.dart';

/// A MarkDown text viewer with optional callback button.
class TextViewer extends StatelessWidget {
  /// The color that will be used in the color Button.
  final Color? buttonColor;

  /// The text color.
  final Color? textColor;

  /// The color used in background and in color Button text.
  final Color? backgroundColor;

  /// The fontFamily from pubspec.
  final String? font;

  final String? package;

  /// The button text.
  final String? buttonText;

  final String title;

  final String mdAsset;

  /// Default constructor for TextViewer
  ///
  /// The TextViewer is fully customizable using this constructor
  ///
  /// Parameters:
  /// - accentColor: The color that will be used in the Color Button. Default #24956A.
  /// - primaryColor: The text color. Default #2D2D2D
  /// - backgroundColor: default #FFFFFF
  /// - font: the fontFamily from pubspec. Default "SpaceGrotesk"
  const TextViewer(this.mdAsset, this.title,
      {super.key,
      this.buttonText,
      this.buttonColor,
      this.textColor,
      this.backgroundColor,
      this.font, this.package});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'TIKI SDK Example App',
    home: WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop(false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop() ),
          title: Text(title),
          actions: [LearnMoreButton()],
        ),
        body: SafeArea(child:
          Column(
            children: [
              Expanded(child: FutureBuilder(
              future: DefaultAssetBundle.of(context).loadString(mdAsset),
                builder: (context, snapshot) {
                  return Markdown(data: snapshot.data!);
                    }
                ),
            ),
            if(buttonText != null) Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 50, left:15, right:15),
              child: Button.solid(buttonText!, () {
                Navigator.of(context).pop(true);
              }, buttonColor))
            ])
        ))));
}
