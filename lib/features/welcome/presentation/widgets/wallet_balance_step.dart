import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/utils/font_aws5_icons.dart';
import '../manager/welcome_cubit.dart';
import '../manager/welcome_state.dart';

class WalletBalanceStep extends StatelessWidget {
  const WalletBalanceStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WelcomeCubit, WelcomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.local.welcomeTitleBalances,
              style: context.textTheme.displaySmall?.copyWith(fontSize: 24.sp),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 8.h),
            Text(
              context.local.welcomeSubTitleBalances,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.theme.hintColor,
                fontSize: 15.sp,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 32.h),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  _BalanceInput(
                    label: context.local.cashBalanceLabel,
                    icon: AwsIcons.money_bill,
                    color: context.colorScheme.primary,
                    initialValue: state.cashBalance?.toString() ?? '',
                    onChanged: (value) => context
                        .read<WelcomeCubit>()
                        .setCashBalance(double.tryParse(value) ?? 0),
                  ),
                  SizedBox(height: 16.h),
                  _BalanceInput(
                    label: context.local.visaBalanceLabel,
                    icon: AwsIcons.credit_card,
                    color: Colors.blue,
                    initialValue: state.visaBalance?.toString() ?? '',
                    onChanged: (value) => context
                        .read<WelcomeCubit>()
                        .setVisaBalance(double.tryParse(value) ?? 0),
                  ),
                  SizedBox(height: 16.h),
                  _BalanceInput(
                    label: context.local.smartWalletBalanceLabel,
                    icon: AwsIcons.mobile,
                    color: Colors.purple,
                    initialValue: state.smartWalletBalance?.toString() ?? '',
                    onChanged: (value) => context
                        .read<WelcomeCubit>()
                        .setSmartWalletBalance(double.tryParse(value) ?? 0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () => context.read<WelcomeCubit>().completeSurvey(),
              style: context.theme.elevatedButtonTheme.style?.copyWith(
                minimumSize: WidgetStateProperty.all(Size.fromHeight(56.h)),
              ),
              child: Text(context.local.startTracking),
            ),
            SizedBox(height: 24.h),
          ],
        );
      },
    );
  }
}

class _BalanceInput extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final String initialValue;
  final ValueChanged<String> onChanged;

  const _BalanceInput({
    required this.label,
    required this.icon,
    required this.color,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: context.theme.dividerColor.withValues(alpha: 0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Icon(icon, color: color, size: 24.sp),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.theme.hintColor,
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '0.00',
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 4.h),
                    suffixText: context.local.currencyEGP,
                    suffixStyle: context.textTheme.bodySmall?.copyWith(
                      color: context.theme.hintColor,
                    ),
                  ),
                  onChanged: onChanged,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
