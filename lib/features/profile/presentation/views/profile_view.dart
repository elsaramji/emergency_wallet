import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/font_aws5_icons.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2F6),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                context.local.profileTitle,
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 28.sp,
                  color: AppColors.ink900,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                context.local.profileSubtitle,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.ink500,
                ),
              ),
              SizedBox(height: 24.h),
              // User Profile Card
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(color: AppColors.ink100, width: 1.5),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundColor: AppColors.primaryLight,
                      child: Icon(AwsIcons.user, color: AppColors.primary, size: 28.sp),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mr. Mahmoud",
                            style: context.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.ink900,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "mahmoud@example.com",
                            style: context.textTheme.bodySmall?.copyWith(
                              color: AppColors.ink500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28.h),
              // Settings Section
              Text(
                context.local.settingsTitle,
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                  color: AppColors.ink900,
                ),
              ),
              SizedBox(height: 16.h),
              // Setting Row: Theme
              _SettingTile(
                icon: AwsIcons.cog,
                iconColor: AppColors.walletSmart,
                title: context.local.settingsTheme,
                trailing: Text(
                  "Light",
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.ink500,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {},
              ),
              SizedBox(height: 12.h),
              // Setting Row: Language
              _SettingTile(
                icon: AwsIcons.globe,
                iconColor: AppColors.walletVisa,
                title: context.local.settingsLanguage,
                trailing: Text(
                  "English",
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.ink500,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {},
              ),
              SizedBox(height: 12.h),
              // Setting Row: Emergency Lock Settings
              _SettingTile(
                icon: AwsIcons.lock,
                iconColor: AppColors.emergency,
                title: "Emergency Rule",
                trailing: Text(
                  "20% Auto-Save",
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.emergency,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {},
              ),
              SizedBox(height: 12.h),
              // Setting Row: Logout
              _SettingTile(
                icon: AwsIcons.power_off,
                iconColor: AppColors.danger,
                title: context.local.settingsLogout,
                onTap: () {},
              ),
              SizedBox(height: 100.h), // padding for bottom nav
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget? trailing;
  final VoidCallback onTap;

  const _SettingTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.ink100, width: 1.5),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 20.sp),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.ink900,
                ),
              ),
            ),
            if (trailing != null) trailing!,
            if (trailing == null)
              Icon(
                AwsIcons.chevron_right,
                color: AppColors.ink300,
                size: 16.sp,
              ),
          ],
        ),
      ),
    );
  }
}
