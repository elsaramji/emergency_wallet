import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../states/welcome_cubit.dart';
import '../states/welcome_state.dart';
import '../widgets/stepper_progress_bar.dart';
import '../widgets/employment_step.dart';
import '../widgets/salary_step.dart';
import '../widgets/activation_step.dart';
import '../widgets/salary_amount_step.dart';
import '../widgets/activation_success_step.dart';
import '../widgets/wallet_balance_step.dart';
import '../../../../core/router/app_routes.dart';
import 'package:go_router/go_router.dart';

class WelcomeQuestionsView extends StatelessWidget {
  const WelcomeQuestionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WelcomeCubit(),
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: BlocListener<WelcomeCubit, WelcomeState>(
            listenWhen: (previous, current) => current.isCompleted,
            listener: (context, state) {
              context.go(AppRoutes.home);
            },
            child: const _WelcomeQuestionsBody(),
          ),
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
              final totalSteps = state.hasStableSalary == true ? 6 : 4;
              return StepperProgressBar(
                currentStep: state.currentStep,
                totalSteps: totalSteps,
              );
            },
          ),
          SizedBox(height: 40.h),
          Expanded(
            child: BlocBuilder<WelcomeCubit, WelcomeState>(
              builder: (context, state) {
                // If current step exceeds total steps, it means we are done
                // But we handle navigation in the widgets or via a listener
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
                  child: _getStepContent(state),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getStepContent(WelcomeState state) {
    final currentStep = state.currentStep;
    final isSalaried = state.hasStableSalary == true;

    if (isSalaried) {
      switch (currentStep) {
        case 0:
          return const EmploymentStep(key: ValueKey(0));
        case 1:
          return const SalaryStep(key: ValueKey(1));
        case 2:
          return const SalaryAmountStep(key: ValueKey(2));
        case 3:
          return const ActivationStep(key: ValueKey(3));
        case 4:
          return const ActivationSuccessStep(key: ValueKey(4));
        case 5:
          return const WalletBalanceStep(key: ValueKey(5));
        default:
          return const EmploymentStep(key: ValueKey(0));
      }
    } else {
      switch (currentStep) {
        case 0:
          return const EmploymentStep(key: ValueKey(0));
        case 1:
          return const SalaryStep(key: ValueKey(1));
        case 2:
          return const ActivationStep(key: ValueKey(2));
        case 3:
          return const WalletBalanceStep(key: ValueKey(3));
        default:
          return const EmploymentStep(key: ValueKey(0));
      }
    }
  }
}
