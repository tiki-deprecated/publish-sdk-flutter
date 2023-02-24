/// {@category UI}
import 'package:flutter/material.dart';

/// The button used in Tiki SDK UIs.
class Button extends StatelessWidget {

  /// The text of the button.
  final String text;

  /// The callback function for button tap.
  final Function onTap;

  /// The button's background color.
  final Color? backgroundColor;

  /// The button's border color.
  final Color? borderColor;

  /// The button's text color.
  final Color? textColor;

  /// The font family of the button's text from pubspec.
  final String? font;

  /// The package that contains the [font] assets.
  final String? package;

  /// The default constructor for outlined button.
  const Button(this.text, this.onTap, this.textColor, this.borderColor,
      {super.key, this.font, this.package}) :
        backgroundColor = const Color(0xFFFFFFFF);

  /// The constructor for a solid color button.
  const Button.solid(this.text, this.onTap, this.backgroundColor,
      {super.key, this.textColor = Colors.white, this.font, this.package})
      : borderColor = backgroundColor;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => onTap,
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: backgroundColor,
                border: Border.all(width: 1.0, color: borderColor ?? Colors.black26),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(text,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        height: 1.2,
                        color: textColor,
                        fontFamily: font,
                        package: package))),
      ));
}
