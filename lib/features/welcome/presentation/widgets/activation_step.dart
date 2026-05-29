import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/font_aws5_icons.dart';
import '../states/welcome_cubit.dart';
import '../states/welcome_state.dart';

class ActivationStep extends StatelessWidget {
  const ActivationStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WelcomeCubit, WelcomeState>(
      builder: (context, state) {
        final hasStableSalary = state.hasStableSalary ?? false;

        if (hasStableSalary) {
          return _buildStableSalaryContent(context, state);
        } else {
          return _buildNoStableSalaryContent(context);
        }
      },
    );
  }

  Widget _buildStableSalaryContent(BuildContext context, WelcomeState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          context.local.welcomeTitleActivation,
          style: context.textTheme.displaySmall?.copyWith(
            fontSize: 24.sp,
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 8.h),
        Text(
          context.local.welcomeSubTitleActivation,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.theme.hintColor,
            fontSize: 15.sp,
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 32.h),
        Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: AppColors.emergencyLight,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.emergency.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: const BoxDecoration(
                  color: AppColors.emergency,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  AwsIcons.shield_alt,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.local.emergencyWalletLabel,
                      style: context.textTheme.labelLarge?.copyWith(
                        color: AppColors.emergencyDark,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      context.local.emergencyWalletAutoSaveDesc,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.emergency,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  context.read<WelcomeCubit>().declineEmergencyWallet();
                  context.read<WelcomeCubit>().nextStep();
                },
                style: context.theme.outlinedButtonTheme.style?.copyWith(
                  minimumSize: WidgetStateProperty.all(Size.fromHeight(56.h)),
                ),
                child: Text(
                  context.local.btnMaybeLater,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {
                  context.read<WelcomeCubit>().activateEmergencyWallet();
                  context.read<WelcomeCubit>().nextStep();
                },
                style: context.theme.elevatedButtonTheme.style?.copyWith(
                  minimumSize: WidgetStateProperty.all(Size.fromHeight(56.h)),
                ),
                child: Text(
                  context.local.btnActivateNow,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _buildNoStableSalaryContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          context.local.welcomeTitleNoSalary,
          style: context.textTheme.displaySmall?.copyWith(
            fontSize: 24.sp,
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 8.h),
        Text(
          context.local.welcomeSubTitleNoSalary,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.theme.hintColor,
            fontSize: 15.sp,
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 32.h),
        Container(
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.primary.withOpacity(0.3)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                AwsIcons.info_circle,
                color: AppColors.primary,
                size: 20.sp,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  context.local.noSalaryInfo,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
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
                onPressed: () {
                  context.read<WelcomeCubit>().nextStep();
                },
                style: context.theme.elevatedButtonTheme.style?.copyWith(
                  minimumSize: WidgetStateProperty.all(Size.fromHeight(56.h)),
                ),
                child: Text(
                  context.local.btnGoToDashboard,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
