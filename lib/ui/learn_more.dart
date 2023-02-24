/// {@category UI}
import 'package:flutter/material.dart';
import 'package:tiki_sdk_flutter/ui/markdown.dart';

class LearnMore extends StatelessWidget {

  final String src;

  final Color? textColor;
  final Color? backgroundColor;

  final String? fontFamily;
  final String? fontPackage;

  const LearnMore(this.src, {super.key,
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
            title: const Text("Learn More"),
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
              ]))));
}