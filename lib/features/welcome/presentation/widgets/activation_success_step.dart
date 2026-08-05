import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../states/welcome_cubit.dart';

class ActivationSuccessStep extends StatefulWidget {
  const ActivationSuccessStep({super.key});

  @override
  State<ActivationSuccessStep> createState() => _ActivationSuccessStepState();
}

class _ActivationSuccessStepState extends State<ActivationSuccessStep>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              color: context.theme.primaryColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: context.theme.primaryColor.withOpacity(0.3),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '🎉',
                style: TextStyle(fontSize: 50.sp),
              ),
            ),
          ),
        ),
        SizedBox(height: 40.h),
        FadeTransition(
          opacity: _opacityAnimation,
          child: Column(
            children: [
              Text(
                context.local.welcomeTitleSuccess,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Text(
                  context.local.welcomeSubTitleSuccess,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.theme.hintColor,
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        FadeTransition(
          opacity: _opacityAnimation,
          child: ElevatedButton(
            onPressed: () => context.read<WelcomeCubit>().nextStep(),
            style: context.theme.elevatedButtonTheme.style?.copyWith(
              minimumSize: WidgetStateProperty.all(Size.fromHeight(56.h)),
            ),
            child: Text(
              context.local.btnContinue,
            ),
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
