import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/font_aws5_icons.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

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
                context.local.historyTitle,
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 28.sp,
                  color: AppColors.ink900,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                context.local.historySubtitle,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.ink500,
                ),
              ),
              SizedBox(height: 24.h),
              // Stripe-inspired search/filter bar
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.ink100, width: 1.5),
                ),
                child: Row(
                  children: [
                    Icon(AwsIcons.search, color: AppColors.ink300, size: 18.sp),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        context.local.search,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.ink300,
                        ),
                      ),
                    ),
                    Icon(AwsIcons.sliders_h, color: AppColors.ink500, size: 18.sp),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              // Dummy Filter chips
              Row(
                children: [
                  _FilterChip(label: context.local.catOthers, isActive: true),
                  SizedBox(width: 8.w),
                  _FilterChip(label: context.local.income, isActive: false),
                  SizedBox(width: 8.w),
                  _FilterChip(label: context.local.expense, isActive: false),
                ],
              ),
              SizedBox(height: 24.h),
              // Mock Transactions List
              _MockTransactionGroup(
                dateLabel: "Today",
                items: [
                  _MockTransactionItem(
                    icon: AwsIcons.utensils,
                    iconBgColor: const Color(0xFFFFF0EB),
                    title: context.local.mockTransTitle1,
                    meta: "2:45 PM • Food & Dining",
                    amount: "-245.00 EGP",
                    isPositive: false,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              _MockTransactionGroup(
                dateLabel: "Yesterday",
                items: [
                  _MockTransactionItem(
                    icon: AwsIcons.money_bill,
                    iconBgColor: const Color(0xFFE0FAF3),
                    title: context.local.mockTransTitle2,
                    meta: "10:00 AM • Salary",
                    amount: "+12,000.00 EGP",
                    isPositive: true,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              _MockTransactionGroup(
                dateLabel: "2 Days Ago",
                items: [
                  _MockTransactionItem(
                    icon: AwsIcons.car,
                    iconBgColor: const Color(0xFFE8F1FF),
                    title: context.local.mockTransTitle3,
                    meta: "6:15 PM • Transport",
                    amount: "-82.00 EGP",
                    isPositive: false,
                  ),
                  SizedBox(height: 12.h),
                  _MockTransactionItem(
                    icon: AwsIcons.shopping_cart,
                    iconBgColor: const Color(0xFFECEBFE),
                    title: "H&M Store",
                    meta: "1:30 PM • Shopping",
                    amount: "-540.00 EGP",
                    isPositive: false,
                  ),
                ],
              ),
              SizedBox(height: 100.h), // padding for bottom nav
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;

  const _FilterChip({
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isActive ? AppColors.primary : AppColors.ink100,
          width: 1.5,
        ),
      ),
      child: Text(
        label,
        style: context.textTheme.labelMedium?.copyWith(
          color: isActive ? AppColors.white : AppColors.ink700,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _MockTransactionGroup extends StatelessWidget {
  final String dateLabel;
  final List<Widget> items;

  const _MockTransactionGroup({
    required this.dateLabel,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dateLabel.toUpperCase(),
          style: context.textTheme.labelMedium?.copyWith(
            color: AppColors.ink500,
            letterSpacing: 0.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12.h),
        ...items,
      ],
    );
  }
}

class _MockTransactionItem extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final String title;
  final String meta;
  final String amount;
  final bool isPositive;

  const _MockTransactionItem({
    required this.icon,
    required this.iconBgColor,
    required this.title,
    required this.meta,
    required this.amount,
    required this.isPositive,
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
            color: AppColors.ink900.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              color: isPositive ? AppColors.successDark : AppColors.primaryDark,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.ink900,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  meta,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 12.sp,
                    color: AppColors.ink500,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: isPositive ? AppColors.success : AppColors.ink900,
            ),
          ),
        ],
      ),
    );
  }
}
