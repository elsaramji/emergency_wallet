import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../manager/welcome_cubit.dart';
import '../manager/welcome_state.dart';
import '../widgets/stepper_progress_bar.dart';
import '../widgets/employment_step.dart';
import '../widgets/salary_step.dart';
import '../widgets/activation_step.dart';

class WelcomeQuestionsView extends StatelessWidget {
  const WelcomeQuestionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WelcomeCubit(),
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        body: const SafeArea(
          child: _WelcomeQuestionsBody(),
        ),
      ),
    );
  }
}

class _WelcomeQuestionsBody extends StatelessWidget {
  const _WelcomeQuestionsBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 24.h),
          BlocBuilder<WelcomeCubit, WelcomeState>(
            builder: (context, state) {
              return StepperProgressBar(
                currentStep: state.currentStep,
                totalSteps: 3,
              );
            },
          ),
          SizedBox(height: 40.h),
          Expanded(
            child: BlocBuilder<WelcomeCubit, WelcomeState>(
              builder: (context, state) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.05, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: _getStepContent(state.currentStep),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getStepContent(int currentStep) {
    switch (currentStep) {
      case 0:
        return const EmploymentStep(key: ValueKey(0));
      case 1:
        return const SalaryStep(key: ValueKey(1));
      case 2:
        return const ActivationStep(key: ValueKey(2));
      default:
        return const EmploymentStep(key: ValueKey(0));
    }
  }
}
