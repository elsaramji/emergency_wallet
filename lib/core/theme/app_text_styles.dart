import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String fontFamily = 'sohne-var';

  // OpenType Features
  static final List<FontFeature> ss01 = [FontFeature.stylisticSet(1)];
  static const List<FontFeature> tnum = [FontFeature.tabularFigures()];

  static TextStyle displayHero = TextStyle(
    fontFamily: fontFamily,
    fontSize: 56.sp,
    fontWeight: FontWeight.w300,
    height: 1.03,
    letterSpacing: -1.4.w,
    color: AppColors.heading,
    fontFeatures: ss01,
  );

  static TextStyle displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 48.sp,
    fontWeight: FontWeight.w300,
    height: 1.15,
    letterSpacing: -0.96.w,
    color: AppColors.heading,
    fontFeatures: ss01,
  );

  static TextStyle sectionHeading = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32.sp,
    fontWeight: FontWeight.w300,
    height: 1.10,
    letterSpacing: -0.64.w,
    color: AppColors.heading,
    fontFeatures: ss01,
  );

  static TextStyle subHeadingLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 26.sp,
    fontWeight: FontWeight.w300,
    height: 1.12,
    letterSpacing: -0.26.w,
    color: AppColors.heading,
    fontFeatures: ss01,
  );

  static TextStyle subHeading = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22.sp,
    fontWeight: FontWeight.w300,
    height: 1.10,
    letterSpacing: -0.22.w,
    color: AppColors.heading,
    fontFeatures: ss01,
  );

  static TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18.sp,
    fontWeight: FontWeight.w300,
    height: 1.40,
    color: AppColors.body,
    fontFeatures: ss01,
  );

  static TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w300,
    height: 1.40,
    color: AppColors.body,
    fontFeatures: ss01,
  );

  static TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    height: 1.0,
    color: AppColors.white,
    fontFeatures: ss01,
  );

  static TextStyle link = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.0,
    color: AppColors.primary,
    fontFeatures: ss01,
  );

  static TextStyle label = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.label,
    fontFeatures: ss01,
  );

  static TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.body,
    fontFeatures: ss01,
  );

  static TextStyle captionTabular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w300,
    height: 1.33,
    letterSpacing: -0.36.w,
    color: AppColors.body,
    fontFeatures: tnum,
  );
}
