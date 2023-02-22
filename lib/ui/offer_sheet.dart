/// {@category UI}
import 'package:flutter/cupertino.dart';
import 'package:tiki_sdk_flutter/ui/completion_sheet.dart';
import 'package:tiki_sdk_flutter/ui/text_viewer.dart';

import 'offer.dart';

/// A dismissible bottom sheet that shows an [Offer] to the user.
///
/// This bottom sheet is the first UI in the TIKI user flow.
/// There are 4 available actions in this screen:
///  - learnMore: will show the [TextViewer] screen with [learnMoreText] loaded.
///  - deny: will show the [CompletionSheet.backoff].
///  - allow: will show the [CompletionSheet.awesome]. If [requireTerms] is
///  true, it will show the [TextViewer] with [termsText] for the user accept the
///  terms before the [CompletionSheet.awesome] screen is shown.
class OfferSheet extends StatelessWidget{

  final Offer offer;
  final bool requireTerms;
  final String? termsText;
  final String? learnMoreText;

  const OfferSheet(this.offer, {super.key,
    this.requireTerms = false,
    this.termsText,
    this.learnMoreText = ""
  });

  @override
  Widget build(BuildContext context) {
    // TODO: https://github.com/tiki/tiki-sdk-flutter/issues/196
    throw UnimplementedError();
  }

}