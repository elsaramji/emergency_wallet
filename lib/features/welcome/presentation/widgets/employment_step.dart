import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/utils/font_aws5_icons.dart';
import '../states/welcome_cubit.dart';
import '../states/welcome_state.dart';

class EmploymentStep extends StatelessWidget {
  const EmploymentStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WelcomeCubit, WelcomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.local.welcomeTitleEmployment,
              style: context.textTheme.displaySmall?.copyWith(
                fontSize: 24.sp,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 8.h),
            Text(
              context.local.welcomeSubTitleEmployment,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.theme.hintColor,
                fontSize: 15.sp,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 32.h),
            _EmploymentOption(
              title: context.local.employmentEmployee,
              description: context.local.employmentEmployeeDesc,
              icon: AwsIcons.briefcase,
              isSelected: state.employmentType == EmploymentType.employee,
              onTap: () => context.read<WelcomeCubit>().selectEmploymentType(EmploymentType.employee),
            ),
            SizedBox(height: 16.h),
            _EmploymentOption(
              title: context.local.employmentFreelancer,
              description: context.local.employmentFreelancerDesc,
              icon: AwsIcons.laptop,
              isSelected: state.employmentType == EmploymentType.freelancer,
              onTap: () => context.read<WelcomeCubit>().selectEmploymentType(EmploymentType.freelancer),
            ),
            SizedBox(height: 16.h),
            _EmploymentOption(
              title: context.local.employmentStudent,
              description: context.local.employmentStudentDesc,
              icon: AwsIcons.graduation_cap,
              isSelected: state.employmentType == EmploymentType.student,
              onTap: () => context.read<WelcomeCubit>().selectEmploymentType(EmploymentType.student),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: state.employmentType != null
                  ? () => context.read<WelcomeCubit>().nextStep()
                  : null,
              style: context.theme.elevatedButtonTheme.style?.copyWith(
                minimumSize: WidgetStateProperty.all(Size.fromHeight(56.h)),
              ),
              child: Text(
                context.local.btnContinue,
              ),
            ),
            SizedBox(height: 24.h),
          ],
        );
      },
    );
  }
}

class _EmploymentOption extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _EmploymentOption({
    required this.title,
    required this.description,
    required this.icon,
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
        padding: EdgeInsets.all(20.r),
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
            Icon(
              icon,
              color: isSelected ? theme.primaryColor : theme.hintColor,
              size: 24.sp,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.labelLarge?.copyWith(
                      color: isSelected ? theme.primaryColor : context.colorScheme.onSurface,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: theme.hintColor,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                AwsIcons.check_circle,
                color: theme.primaryColor,
                size: 20.sp,
              ),
          ],
        ),
      ),
    );
  }
}
