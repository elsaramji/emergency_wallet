import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/extensions/context_extensions.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/font_aws5_icons.dart';
import '../../features/dashboard/presentation/states/dashboard_cubit.dart';
import 'transaction_form_dialog.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 84.h,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: const Border(top: BorderSide(color: AppColors.ink100)),
            boxShadow: [
              BoxShadow(
                color: AppColors.ink900.withOpacity(0.03),
                blurRadius: 30,
                offset: const Offset(0, -10),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NavItem(
                icon: AwsIcons.home,
                label: context.local.navHome,
                isActive: true,
              ),
              _NavItem(
                icon: AwsIcons.history,
                label: context.local.navHistory,
                isActive: false,
              ),
              SizedBox(width: 56.w), // Spacer for FAB
              _NavItem(
                icon: AwsIcons.chart_pie,
                label: context.local.navInsights,
                isActive: false,
              ),
              _NavItem(
                icon: AwsIcons.user,
                label: context.local.navProfile,
                isActive: false,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 40.h,
          child: FloatingActionButton(
            onPressed: () => _showTransactionDialog(context),
            backgroundColor: AppColors.primary,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(AwsIcons.plus, color: AppColors.white, size: 24.sp),
          ),
        ),
      ],
    );
  }

  void _showTransactionDialog(BuildContext context) {
    final cubit = context.read<DashboardCubit>();
    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        backgroundColor: AppColors.white,
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.local.newTransaction,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink900,
                ),
              ),
              SizedBox(height: 24.h),
              _TransactionTypeItem(
                title: context.local.cashIn,
                icon: AwsIcons.plus_circle,
                color: AppColors.success,
                onTap: () {
                  Navigator.pop(dialogContext);
                  showDialog(
                    context: context,
                    builder: (context) =>
                        TransactionFormDialog(isCashIn: true, dashboardCubit: cubit),
                  );
                },
              ),
              SizedBox(height: 12.h),
              _TransactionTypeItem(
                title: context.local.cashOut,
                icon: AwsIcons.minus_circle,
                color: AppColors.primary,
                onTap: () {
                  Navigator.pop(dialogContext);
                  showDialog(
                    context: context,
                    builder: (context) =>
                        TransactionFormDialog(isCashIn: false, dashboardCubit: cubit),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.primary : AppColors.ink500,
            size: 24.sp,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: isActive ? AppColors.primary : AppColors.ink500,
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionTypeItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _TransactionTypeItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.ink100),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24.sp),
            ),
            SizedBox(width: 16.w),
            Text(
              title,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.ink900,
              ),
            ),
            const Spacer(),
            Icon(AwsIcons.chevron_right, color: AppColors.ink300, size: 16.sp),
          ],
        ),
      ),
    );
  }
}
