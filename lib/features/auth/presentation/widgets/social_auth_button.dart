import 'package:emergency_wallet/core/utils/font_aws5_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SocialAuthButton extends StatelessWidget {
  final String text;
  final String icon;
  final VoidCallback onPressed;

  const SocialAuthButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          side: const BorderSide(color: AppColors.ink100, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(AwsIcons.google, color: AppColors.ink900, size: 24.sp),
            SizedBox(width: 12.w),
            Text(
              text,
              style: AppTextStyles.labelLarge.copyWith(color: AppColors.ink900),
            ),
          ],
        ),
      ),
    );
  }
}
