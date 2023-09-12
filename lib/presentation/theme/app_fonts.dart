import 'dart:ui';


import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

sealed class AppFonts {
  static const FontWeight light = FontWeight.w200;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight w600 = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w900;

  static final appbarTextStyle = GoogleFonts.nunitoSans(
    color: AppColors.white,
    fontWeight: bold,
    fontSize: 18.0,
    height: 2.0,
  );
  static final headlineLarge = GoogleFonts.nunitoSans(
    fontSize: 24.0,
    color: AppColors.text,
    fontWeight: bold,
  );
  static final bodySmall = GoogleFonts.nunitoSans(
    fontSize: 12.0,
    color: AppColors.textGrey,
    fontWeight: regular,
  );
  static final bodyMedium = GoogleFonts.nunitoSans(
    fontSize: 14.0,
    color: AppColors.text,
    fontWeight: bold,
  );
  static final textButton = GoogleFonts.nunitoSans(
    fontSize: 14.0,
    color: AppColors.white,
    fontWeight: bold,
  );



}
