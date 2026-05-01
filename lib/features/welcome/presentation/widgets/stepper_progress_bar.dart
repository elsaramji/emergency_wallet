import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/context_extensions.dart';

class StepperProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepperProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        final isActive = index <= currentStep;
        return Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsetsDirectional.only(
              end: index == totalSteps - 1 ? 0 : 8.w,
            ),
            height: 6.h,
            decoration: BoxDecoration(
              color: isActive ? context.theme.primaryColor : context.theme.dividerColor,
              borderRadius: BorderRadius.circular(9999.r),
            ),
          ),
        );
      }),
    );
  }
}
