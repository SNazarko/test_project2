
import 'package:flutter/material.dart';
import 'package:test_project/presentation/theme/app_fonts.dart';

import 'app_colors.dart';

class AppThemes {
  const AppThemes._();

  static ThemeData light() {
    return ThemeData.light().copyWith(
      appBarTheme: AppBarTheme(
        centerTitle: true,
          backgroundColor: AppColors.white,
        titleTextStyle: AppFonts.appbarTextStyle,
          elevation: 0
      ),
      textTheme: TextTheme(
        headlineLarge: AppFonts.headlineLarge,
        bodySmall:  AppFonts.bodySmall,
        bodyMedium: AppFonts.bodyMedium,
        labelLarge: AppFonts.textButton,
      ),
       scaffoldBackgroundColor: AppColors.white
    );
  }
}