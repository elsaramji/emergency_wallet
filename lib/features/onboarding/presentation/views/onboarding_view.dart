import 'package:emergency_wallet/core/blocs/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/font_aws5_icons.dart';
import '../widgets/onboarding_slide.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  List<Map<String, dynamic>> _getSlides(BuildContext context) => [
    {
      'icon': AwsIcons.wallet,
      'color': AppColors.walletCash,
      'title': context.local.onboardingTitle1,
      'description': context.local.onboardingDescription1,
    },
    {
      'icon': AwsIcons.shield_alt,
      'color': AppColors.walletEmergency,
      'title': context.local.onboardingTitle2,
      'description': context.local.onboardingDescription2,
    },
    {
      'icon': AwsIcons.chart_line,
      'color': AppColors.primary,
      'title': context.local.onboardingTitle3,
      'description': context.local.onboardingDescription3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final slides = _getSlides(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: slides.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingSlide(
                    icon: slides[index]['icon'] as IconData,
                    iconColor: slides[index]['color'] as Color,
                    title: slides[index]['title'] as String,
                    description: slides[index]['description'] as String,
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      slides.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        height: 8.h,
                        width: _currentIndex == index ? 24.w : 8.w,
                        decoration: BoxDecoration(
                          color: _currentIndex == index
                              ? AppColors.primary
                              : AppColors.ink300,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentIndex == slides.length - 1) {
                          context.read<AppCubit>().markOnboardingViewed();
                          context.goNamed(AppRoutes.login);
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: Text(
                        _currentIndex == slides.length - 1
                            ? context.local.getStarted
                            : context.local.next,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
