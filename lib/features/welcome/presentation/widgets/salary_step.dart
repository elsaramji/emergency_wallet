import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/context_extensions.dart';
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
                fontWeight: FontWeight.w300,
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
      borderRadius: BorderRadius.circular(20.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? theme.primaryColor : theme.dividerColor.withOpacity(0.08),
            width: isSelected ? 2.w : 1.5.w,
          ),
          borderRadius: BorderRadius.circular(20.r),
          color: isSelected ? theme.primaryColor.withOpacity(0.04) : Colors.transparent,
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: theme.primaryColor.withOpacity(0.08),
                blurRadius: 16.r,
                spreadRadius: 1.r,
                offset: const Offset(0, 4),
              )
            else
              BoxShadow(
                color: Colors.black.withOpacity(0.01),
                blurRadius: 10.r,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: context.textTheme.labelLarge?.copyWith(
                  color: isSelected ? theme.primaryColor : context.colorScheme.onSurface,
                  fontSize: 16.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? theme.primaryColor : theme.dividerColor.withOpacity(0.3),
                  width: 2.w,
                ),
                color: isSelected ? theme.primaryColor : Colors.transparent,
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10.w,
                        height: 10.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
