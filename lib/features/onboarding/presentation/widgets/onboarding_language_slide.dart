import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/blocs/app_cubit.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/utils/font_aws5_icons.dart';

class OnboardingLanguageSlide extends StatelessWidget {
  const OnboardingLanguageSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        final currentLocale = state.locale ?? 'en';

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Globe Icon matching visual mockup
              Container(
                width: 100.r,
                height: 100.r,
                decoration: BoxDecoration(
                  color: context.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  AwsIcons.globe,
                  size: 56.r,
                  color: context.colorScheme.primary,
                ),
              ),
              SizedBox(height: 32.h),
              
              // Title
              Text(
                context.local.languageSelectionTitle,
                textAlign: TextAlign.center,
                style: context.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.h),
              
              // Subtitle
              Text(
                context.local.languageSelectionSubtitle,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.textMuted,
                ),
              ),
              SizedBox(height: 40.h),
              
              // English Option Card
              _LanguageCard(
                avatarText: 'A',
                title: context.local.languageEnglish,
                description: context.local.languageEnglishDesc,
                isSelected: currentLocale == 'en',
                onTap: () => context.read<AppCubit>().changeLocale('en'),
              ),
              SizedBox(height: 16.h),
              
              // Arabic Option Card
              _LanguageCard(
                avatarText: 'ع',
                title: context.local.languageArabic,
                description: context.local.languageArabicDesc,
                isSelected: currentLocale == 'ar',
                onTap: () => context.read<AppCubit>().changeLocale('ar'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LanguageCard extends StatelessWidget {
  final String avatarText;
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageCard({
    required this.avatarText,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? context.colorScheme.primary : context.ink100,
            width: 2.w,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: context.colorScheme.primary.withOpacity(0.1),
                    blurRadius: 15.r,
                    offset: Offset(0, 4.h),
                  )
                ]
              : [
                  BoxShadow(
                    color: context.colorScheme.onSurface.withOpacity(0.02),
                    blurRadius: 5.r,
                    offset: Offset(0, 2.h),
                  )
                ],
        ),
        child: Row(
          children: [
            // Styled Typography Avatar ('A' / 'ع')
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: isSelected ? context.colorScheme.primary : context.theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: isSelected ? context.colorScheme.primary : context.ink100,
                  width: 1.w,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                avatarText,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isSelected ? context.colorScheme.onPrimary : context.colorScheme.onSurface,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            
            // Text Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.textMuted,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            
            // Selection Radio Dot
            Container(
              width: 24.r,
              height: 24.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? context.colorScheme.primary : context.ink300,
                  width: 2.w,
                ),
                color: isSelected ? context.colorScheme.primary : Colors.transparent,
              ),
              alignment: Alignment.center,
              child: isSelected
                  ? Container(
                      width: 10.r,
                      height: 10.r,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
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
