import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableText extends StatelessWidget {
  final String text;

  final double fontSize;
  final FontWeight fontWeight;

  ReusableText({
    required this.text,

    this.fontSize = 16.0,
    this.fontWeight = FontWeight.normal,
    style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}

class Heading extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;

  Heading(
      {required this.text,
      required this.color,
      required this.fontSize,
      required this.fontWeight});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
