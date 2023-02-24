/// {@category UI}
import 'package:flutter/material.dart';
import 'button.dart';
import 'markdown.dart';

class Terms extends StatelessWidget {

  final Color? buttonColor;
  final Color? textColor;
  final Color? backgroundColor;

  final String src;

  final String? fontFamily;
  final String? fontPackage;

  const Terms(this.src, {super.key,
        this.buttonColor,
        this.textColor,
        this.backgroundColor,
        this.fontFamily,
        this.fontPackage});

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop(false);
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop()),
            title: const Text("Terms and Conditions"),
          ),
          body: SafeArea(
              child: Column(children: [
                Expanded(
                  child: FutureBuilder(
                      future: DefaultAssetBundle.of(context).loadString(src),
                      builder: (context, snapshot) {
                        return MarkdownViewer(snapshot.data!,
                            textColor: textColor,
                            fontSize: 20,
                            fontPackage: fontPackage,
                            fontFamily: fontFamily);
                      }),
                ),
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 40, bottom: 50, left: 15, right: 15),
                      child: Button.solid("I agree", () {
                        Navigator.of(context).pop(true);
                      }, buttonColor))
              ]))));
}