import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../../core/extensions/context_extensions.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/font_aws5_icons.dart';
import '../../features/dashboard/presentation/states/dashboard_cubit.dart';
import 'transaction_form_dialog.dart';

class MainShellView extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainShellView({super.key, required this.navigationShell});

  @override
  State<MainShellView> createState() => _MainShellViewState();
}

class _MainShellViewState extends State<MainShellView> {
  @override
  Widget build(BuildContext context) {
    final int shellIndex = widget.navigationShell.currentIndex;
    final int navBarIndex = shellIndex >= 2 ? shellIndex + 1 : shellIndex;

    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<DashboardCubit>();

          return Scaffold(
            backgroundColor: const Color(0xFFEEF2F6),
            body: widget.navigationShell,
            bottomNavigationBar: Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                CurvedNavigationBar(
                  index: navBarIndex,
                  height: 65.h,
                  items: <Widget>[
                    Icon(
                      AwsIcons.home,
                      size: 22.sp,
                      color: navBarIndex == 0
                          ? AppColors.white
                          : AppColors.ink500,
                    ),
                    Icon(
                      AwsIcons.history,
                      size: 22.sp,
                      color: navBarIndex == 1
                          ? AppColors.white
                          : AppColors.ink500,
                    ),

                    SizedBox(width: 50.w),

                    Icon(
                      AwsIcons.chart_pie,
                      size: 22.sp,
                      color: navBarIndex == 3
                          ? AppColors.white
                          : AppColors.ink500,
                    ),
                    Icon(
                      AwsIcons.user,
                      size: 22.sp,
                      color: navBarIndex == 4
                          ? AppColors.white
                          : AppColors.ink500,
                    ),
                  ],
                  color: AppColors.white,
                  buttonBackgroundColor: AppColors.primary,
                  backgroundColor: const Color(0xFFEEF2F6),
                  animationCurve: Curves.easeInOut,
                  animationDuration: const Duration(milliseconds: 300),
                  letIndexChange: (value) {
                    if (value == 2) {
                      return false;
                    } else {
                      return true;
                    }
                  },
                  onTap: (index) {
                    final int targetBranch = index > 2 ? index - 1 : index;
                    widget.navigationShell.goBranch(targetBranch);
                  },
                ),

                Positioned(
                  bottom: 30.h,
                  child: FloatingActionButton(
                    onPressed: () => _showTransactionDialog(context, cubit),
                    backgroundColor: AppColors.primary,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Icon(
                      AwsIcons.plus,
                      color: AppColors.white,
                      size: 24.sp,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showTransactionDialog(BuildContext context, DashboardCubit cubit) {
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
                    builder: (context) => TransactionFormDialog(
                      isCashIn: true,
                      dashboardCubit: cubit,
                    ),
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
                    builder: (context) => TransactionFormDialog(
                      isCashIn: false,
                      dashboardCubit: cubit,
                    ),
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
