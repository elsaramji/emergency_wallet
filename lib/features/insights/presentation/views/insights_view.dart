import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/font_aws5_icons.dart';

class InsightsView extends StatelessWidget {
  const InsightsView({super.key});

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
                context.local.insightsTitle,
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 28.sp,
                  color: AppColors.ink900,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                context.local.insightsSubtitle,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.ink500,
                ),
              ),
              SizedBox(height: 24.h),
              // Premium Card: Emergency Wallet Auto-Save Status
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, Color(0xFF7F6BFF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context.local.emergencyWalletLabel.toUpperCase(),
                          style: context.textTheme.labelMedium?.copyWith(
                            color: AppColors.white.withOpacity(0.8),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        Icon(AwsIcons.lock, color: AppColors.white, size: 18.sp),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "2,490.00 EGP",
                      style: context.textTheme.displayMedium?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      context.local.emergencyWalletAutoSaveDesc,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: AppColors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28.h),
              // Section: Spending Breakdown
              Text(
                context.local.categoryLabel,
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                  color: AppColors.ink900,
                ),
              ),
              SizedBox(height: 16.h),
              _CategoryBreakdownItem(
                categoryName: context.local.catFood,
                percentage: 45,
                amount: "-1,120.00 EGP",
                color: AppColors.warning,
              ),
              SizedBox(height: 12.h),
              _CategoryBreakdownItem(
                categoryName: context.local.catTransport,
                percentage: 25,
                amount: "-620.00 EGP",
                color: AppColors.walletVisa,
              ),
              SizedBox(height: 12.h),
              _CategoryBreakdownItem(
                categoryName: context.local.catOthers,
                percentage: 30,
                amount: "-750.00 EGP",
                color: AppColors.walletSmart,
              ),
              SizedBox(height: 28.h),
              // KPI / Month comparison
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(color: AppColors.ink100, width: 1.5),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: const BoxDecoration(
                        color: AppColors.successLight,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(AwsIcons.arrow_down, color: AppColors.successDark, size: 20.sp),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Savings Rate",
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.ink900,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "You saved 12% more than last month.",
                            style: context.textTheme.bodySmall?.copyWith(
                              color: AppColors.ink500,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100.h), // padding for bottom nav
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryBreakdownItem extends StatelessWidget {
  final String categoryName;
  final int percentage;
  final String amount;
  final Color color;

  const _CategoryBreakdownItem({
    required this.categoryName,
    required this.percentage,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.ink900.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                categoryName,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.ink900,
                ),
              ),
              Text(
                amount,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink900,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: LinearProgressIndicator(
                    value: percentage / 100,
                    backgroundColor: AppColors.ink100,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 8.h,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                "$percentage%",
                style: context.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink500,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
