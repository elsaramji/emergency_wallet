import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();
  static const String fontFamily = 'Cairo';
  static TextStyle displayXl = TextStyle(
    fontFamily: fontFamily,
    fontSize: 48.sp,
    fontWeight: FontWeight.w700,
    height: 1.1,
    color: AppColors.ink900,
  );

  static TextStyle displayLg = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36.sp,
    fontWeight: FontWeight.w700,
    height: 1.2,
    color: AppColors.ink900,
  );

  static TextStyle displayMd = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28.sp,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: AppColors.ink900,
  );

  static TextStyle h1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    height: 1.3,
    color: AppColors.ink900,
  );

  static TextStyle h2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.ink900,
  );

  static TextStyle h3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 17.sp,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.ink900,
  );

  static TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.ink900,
  );

  static TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.ink900,
  );

  static TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.ink900,
  );

  static TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.ink900,
  );

  static TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.ink900,
  );

  static TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.ink900,
  );

  static TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.ink500,
  );

  static TextStyle overline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.06,
    color: AppColors.ink500,
  );
}
