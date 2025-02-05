import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_application/app/utils/color_manager.dart';

class TextStyleManager {
  // Heading style
  static final TextStyle headingTextStyle = GoogleFonts.rugeBoogie(
    fontSize: 28.sp,
    color: ColorManager.white,
    fontWeight: FontWeight.w800,
  );

  static final TextStyle mainTextStyle = GoogleFonts.majorMonoDisplay(
    fontSize: 14.sp,
    color: ColorManager.black,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle subTextStyle = GoogleFonts.montserrat(
    fontSize: 13.sp,
    color: ColorManager.appBarColor,
    fontWeight: FontWeight.w500,
  );
}