import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/font_aws5_icons.dart';
import '../../../../shared/widgets/transaction_form_dialog.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 32.h),
      child: Row(
        children: [
          Expanded(
            child: _ActionBtn(
              title: context.local.cashIn,
              icon: AwsIcons.arrow_down,
              bgColor: AppColors.successLight,
              textColor: AppColors.successDark,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const TransactionFormDialog(isCashIn: true),
                );
              },
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _ActionBtn(
              title: context.local.cashOut,
              icon: AwsIcons.arrow_up,
              bgColor: AppColors.primaryLight,
              textColor: AppColors.primaryDark,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const TransactionFormDialog(isCashIn: false),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color bgColor;
  final Color textColor;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.title,
    required this.icon,
    required this.bgColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        height: 52.h,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.ink900.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              title,
              style: context.textTheme.bodyMedium?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
