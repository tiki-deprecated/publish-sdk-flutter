/// {@category UI}
import 'package:flutter/material.dart';

/// The card that represents an offer
class OfferCard extends StatelessWidget {
  final Image image;
  final String description;
  final Color? textColor;
  final Color? backgroundColor;
  final String? fontFamily;
  final String? package;

  const OfferCard(this.image, this.description, {super.key,
    this.textColor,
    this.backgroundColor,
    this.fontFamily, this.package});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: backgroundColor,
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(13, 0, 0, 0), offset: Offset(4, 4))
                ],
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                            width: 300,
                            height: 86,
                            child: image),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: RichText(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: description,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  height: 1.2,
                                  color: textColor,
                                  fontFamily: fontFamily,
                                  package: package))),
                    )
                  ],
                ))),
      );
}
