import 'package:emergency_wallet/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/font_aws5_icons.dart';
import '../states/dashboard_cubit.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.local.recentActivity,
              style: context.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
              ),
            ),
            TextButton(
              onPressed: () {
                context.go(AppRoutes.history);
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                context.local.viewAll,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        _TransactionItem(
          icon: AwsIcons.utensils,
          iconBgColor: const Color(0xFFFFF0EB),
          title: context.local.mockTransTitle1,
          meta: context.local.mockTransMeta1,
          amount: "-245.00",
          isPositive: false,
        ),
        SizedBox(height: 12.h),
        _TransactionItem(
          icon: AwsIcons.money_bill,
          iconBgColor: const Color(0xFFE0FAF3),
          title: context.local.mockTransTitle2,
          meta: context.local.mockTransMeta2,
          amount: "+12,000.00",
          isPositive: true,
        ),
        SizedBox(height: 12.h),
        _TransactionItem(
          icon: AwsIcons.car,
          iconBgColor: const Color(0xFFE8F1FF),
          title: context.local.mockTransTitle3,
          meta: context.local.mockTransMeta3,
          amount: "-82.00",
          isPositive: false,
        ),
        SizedBox(height: 100.h), // padding for bottom nav
      ],
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final String title;
  final String meta;
  final String amount;
  final bool isPositive;

  const _TransactionItem({
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
            color: AppColors.ink900.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
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
          BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, state) {
              return Text(
                state.isBalanceVisible ? amount : "••••",
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isPositive ? AppColors.success : AppColors.ink900,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
