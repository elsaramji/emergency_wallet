import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_text_styles.dart';

class OnboardingSlide extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;

  const OnboardingSlide({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 120.r, color: iconColor),
          SizedBox(height: 40.h),
          Text(title, textAlign: TextAlign.center, style: AppTextStyles.h1),
          SizedBox(height: 16.h),
          Text(
            description,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge,
          ),
        ],
      ),
    );
  }
}
