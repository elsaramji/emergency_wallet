import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/utils/font_aws5_icons.dart';
import '../states/welcome_cubit.dart';
import '../states/welcome_state.dart';

class SalaryStep extends StatelessWidget {
  const SalaryStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WelcomeCubit, WelcomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.local.welcomeTitleSalary,
              style: context.textTheme.displaySmall?.copyWith(
                fontSize: 24.sp,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 8.h),
            Text(
              context.local.welcomeSubTitleSalary,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.theme.hintColor,
                fontSize: 15.sp,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 32.h),
            _SalaryOption(
              title: context.local.salaryYes,
              isSelected: state.hasStableSalary == true,
              onTap: () => context.read<WelcomeCubit>().setStableSalary(true),
            ),
            SizedBox(height: 16.h),
            _SalaryOption(
              title: context.local.salaryNo,
              isSelected: state.hasStableSalary == false,
              onTap: () => context.read<WelcomeCubit>().setStableSalary(false),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.read<WelcomeCubit>().previousStep(),
                    style: context.theme.outlinedButtonTheme.style?.copyWith(
                      minimumSize: WidgetStateProperty.all(Size.fromHeight(56.h)),
                    ),
                    child: Text(
                      context.local.btnBack,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: state.hasStableSalary != null
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

class _SalaryOption extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _SalaryOption({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? theme.primaryColor : theme.dividerColor,
            width: isSelected ? 2.w : 1.w,
          ),
          borderRadius: BorderRadius.circular(16.r),
          color: isSelected ? theme.primaryColor.withOpacity(0.08) : Colors.transparent,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: context.textTheme.labelLarge?.copyWith(
                  color: isSelected ? theme.primaryColor : context.colorScheme.onSurface,
                  fontSize: 16.sp,
                ),
              ),
            ),
            Icon(
              isSelected ? AwsIcons.check_circle : AwsIcons.circle,
              color: isSelected ? theme.primaryColor : theme.dividerColor,
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }
}
