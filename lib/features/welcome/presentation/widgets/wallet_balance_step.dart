import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../states/welcome_cubit.dart';
import '../states/welcome_state.dart';

class WalletBalanceStep extends StatelessWidget {
  const WalletBalanceStep({super.key});

  String _formatBalance(double? value) {
    if (value == null || value == 0) return '';
    if (value % 1 == 0) return value.toInt().toString();
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WelcomeCubit, WelcomeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.local.welcomeTitleBalances,
              style: context.textTheme.displaySmall?.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 8.h),
            Text(
              context.local.welcomeSubTitleBalances,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.theme.hintColor,
                fontSize: 15.sp,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 32.h),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  _BalanceInput(
                    label: context.local.cashBalanceLabel,
                    icon: '💵',
                    color: context.cashColor,
                    initialValue: _formatBalance(state.cashBalance),
                    onChanged: (value) => context
                        .read<WelcomeCubit>()
                        .setCashBalance(double.tryParse(value) ?? 0),
                  ),
                  SizedBox(height: 16.h),
                  _BalanceInput(
                    label: context.local.visaBalanceLabel,
                    icon: '💳',
                    color: context.visaColor,
                    initialValue: _formatBalance(state.visaBalance),
                    onChanged: (value) => context
                        .read<WelcomeCubit>()
                        .setVisaBalance(double.tryParse(value) ?? 0),
                  ),
                  SizedBox(height: 16.h),
                  _BalanceInput(
                    label: context.local.smartWalletBalanceLabel,
                    icon: '📱',
                    color: context.smartWalletColor,
                    initialValue: _formatBalance(state.smartWalletBalance),
                    onChanged: (value) => context
                        .read<WelcomeCubit>()
                        .setSmartWalletBalance(double.tryParse(value) ?? 0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () => context.read<WelcomeCubit>().completeSurvey(),
              style: context.theme.elevatedButtonTheme.style?.copyWith(
                minimumSize: WidgetStateProperty.all(Size.fromHeight(56.h)),
              ),
              child: Text(context.local.startTracking),
            ),
            SizedBox(height: 24.h),
          ],
        );
      },
    );
  }
}

class _BalanceInput extends StatefulWidget {
  final String label;
  final String icon;
  final Color color;
  final String initialValue;
  final ValueChanged<String> onChanged;

  const _BalanceInput({
    required this.label,
    required this.icon,
    required this.color,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<_BalanceInput> createState() => _BalanceInputState();
}

class _BalanceInputState extends State<_BalanceInput> {
  late final FocusNode _focusNode;
  late final TextEditingController _controller;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(_BalanceInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue &&
        widget.initialValue != _controller.text) {
      final selection = _controller.selection;
      _controller.text = widget.initialValue;
      try {
        _controller.selection = selection;
      } catch (_) {}
    }
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
    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: _isFocused
                ? widget.color
                : context.theme.dividerColor.withOpacity(0.08),
            width: _isFocused ? 2.w : 1.5.w,
          ),
          boxShadow: [
            if (_isFocused)
              BoxShadow(
                color: widget.color.withOpacity(0.12),
                blurRadius: 16.r,
                spreadRadius: 1.r,
                offset: const Offset(0, 4),
              )
            else
              BoxShadow(
                color: Colors.black.withOpacity(0.015),
                blurRadius: 10.r,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56.w,
              height: 56.h,
              decoration: BoxDecoration(
                color: widget.color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Center(
                child: Text(
                  widget.icon,
                  style: TextStyle(fontSize: 28.sp),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.label.toUpperCase(),
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.theme.hintColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  TextField(
                    focusNode: _focusNode,
                    controller: _controller,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: context.textTheme.titleLarge?.copyWith(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: '0.00',
                      filled: false,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 2.h),
                      suffixText: context.local.currencyEGP,
                      suffixStyle: context.textTheme.bodyMedium?.copyWith(
                        color: context.theme.hintColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onChanged: widget.onChanged,
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
