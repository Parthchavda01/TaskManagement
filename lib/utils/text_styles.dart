import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

montserratTextStyle(context,{color,fontsize}) {
  return GoogleFonts.montserrat(fontSize:fontsize?? 17,fontWeight: FontWeight.w600,color: color??Colors.black);
}

openSansTextStyle(context,{color,fontsize,fontweight}) {
  return GoogleFonts.openSans(fontSize:fontsize?? 13,color: color??Colors.black,fontWeight:fontweight??FontWeight.w500 );
}



