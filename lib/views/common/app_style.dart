import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


// TextStyle app_style(double size, Color color, FontWeight fw){
//
//   return GoogleFonts.poppins(fontSize:size.sp, color:color,fontWeight: fw );
// }
TextStyle app_style({
  required double size,
  required Color color,
  required FontWeight fw,
}) {
  return TextStyle(
    color: color,
    fontWeight: fw,
    // Add other text style properties as needed
  );
}
