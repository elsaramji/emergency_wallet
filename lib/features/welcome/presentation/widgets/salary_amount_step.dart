import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../states/welcome_cubit.dart';
import '../states/welcome_state.dart';

class SalaryAmountStep extends StatefulWidget {
  const SalaryAmountStep({super.key});

  @override
  State<SalaryAmountStep> createState() => _SalaryAmountStepState();
}

class _SalaryAmountStepState extends State<SalaryAmountStep> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<WelcomeCubit>();
    final initialValue = cubit.state.salaryAmount?.toString() ?? '';
    _controller = TextEditingController(text: initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WelcomeCubit, WelcomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.local.welcomeTitleSalaryAmount,
              style: context.textTheme.displaySmall?.copyWith(
                fontSize: 24.sp,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 8.h),
            Text(
              context.local.welcomeSubTitleSalaryAmount,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.theme.hintColor,
                fontSize: 15.sp,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 40.h),
            Container(
              decoration: BoxDecoration(
                color: context.theme.primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: context.theme.primaryColor.withOpacity(0.1),
                  width: 1.w,
                ),
              ),
              padding: EdgeInsets.all(24.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.local.salaryAmountLabel,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.theme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 32.sp,
                      color: context.colorScheme.onSurface,
                    ),
                    decoration: InputDecoration(
                      hintText: context.local.salaryAmountHint,
                      border: InputBorder.none,
                      suffixText: context.local.currencyEGP,
                      suffixStyle: context.textTheme.titleMedium?.copyWith(
                        color: context.theme.hintColor,
                        fontWeight: FontWeight.w500,
                      ),
                      hintStyle: context.textTheme.headlineMedium?.copyWith(
                        color: context.theme.hintColor.withOpacity(0.3),
                        fontWeight: FontWeight.bold,
                        fontSize: 32.sp,
                      ),
                    ),
                    onChanged: (value) {
                      final amount = double.tryParse(value);
                      if (amount != null) {
                        context.read<WelcomeCubit>().setSalaryAmount(amount);
                      }
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => context.read<WelcomeCubit>().previousStep(),
                    style: TextButton.styleFrom(
                      minimumSize: Size.fromHeight(56.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Text(
                      context.local.btnBack,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: state.salaryAmount != null && state.salaryAmount! > 0
                        ? () => context.read<WelcomeCubit>().nextStep()
                        : null,
                    style: context.theme.elevatedButtonTheme.style?.copyWith(
                      minimumSize: WidgetStateProperty.all(Size.fromHeight(56.h)),
                    ),
                    child: Text(
                      context.local.btnContinue,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
          ],
        );
      },
    );
  }
}
