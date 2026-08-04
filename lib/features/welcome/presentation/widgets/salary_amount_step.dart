import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../states/welcome_cubit.dart';
import '../states/welcome_state.dart';

class SalaryAmountStep extends StatefulWidget {
  const SalaryAmountStep({super.key});

  @override
  State<SalaryAmountStep> createState() => _SalaryAmountStepState();
}

class _SalaryAmountStepState extends State<SalaryAmountStep> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<WelcomeCubit>();
    final initialValue = cubit.state.salaryAmount?.toString() ?? '';
    _controller = TextEditingController(text: initialValue);
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return BlocBuilder<WelcomeCubit, WelcomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.local.welcomeTitleSalaryAmount,
              style: context.textTheme.displaySmall?.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 8.h),
            Text(
              context.local.welcomeSubTitleSalaryAmount,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.theme.hintColor,
                fontSize: 15.sp,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 40.h),
            GestureDetector(
              onTap: () => _focusNode.requestFocus(),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: _isFocused
                        ? theme.primaryColor
                        : theme.primaryColor.withOpacity(0.12),
                    width: _isFocused ? 2.w : 1.5.w,
                  ),
                  boxShadow: [
                    if (_isFocused)
                      BoxShadow(
                        color: theme.primaryColor.withOpacity(0.12),
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
                padding: EdgeInsets.all(24.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.local.salaryAmountLabel,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    TextField(
                      focusNode: _focusNode,
                      controller: _controller,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      style: context.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 32.sp,
                        color: context.colorScheme.onSurface,
                      ),
                      decoration: InputDecoration(
                        hintText: context.local.salaryAmountHint,
                        filled: false,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 4.h),
                        suffixText: context.local.currencyEGP,
                        suffixStyle: context.textTheme.titleMedium?.copyWith(
                          color: context.theme.hintColor,
                          fontWeight: FontWeight.w600,
                        ),
                        hintStyle: context.textTheme.headlineMedium?.copyWith(
                          color: context.theme.hintColor.withOpacity(0.3),
                          fontWeight: FontWeight.bold,
                          fontSize: 32.sp,
                        ),
                      ),
                      onChanged: (value) {
                        final amount = double.tryParse(value);
                        if (amount != null) {
                          context.read<WelcomeCubit>().setSalaryAmount(amount);
                        } else if (value.isEmpty) {
                          context.read<WelcomeCubit>().setSalaryAmount(0);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => context.read<WelcomeCubit>().previousStep(),
                    style: TextButton.styleFrom(
                      minimumSize: Size.fromHeight(56.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: Text(
                      context.local.btnBack,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: state.salaryAmount != null && state.salaryAmount! > 0
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
