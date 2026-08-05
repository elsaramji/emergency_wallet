import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../states/welcome_cubit.dart';
import '../states/welcome_state.dart';

class ActivationStep extends StatefulWidget {
  const ActivationStep({super.key});

  @override
  State<ActivationStep> createState() => _ActivationStepState();
}

class _ActivationStepState extends State<ActivationStep> {
  late final TextEditingController _customController;
  late final FocusNode _customFocusNode;
  bool _isCustomSelected = false;

  @override
  void initState() {
    super.initState();
    _customController = TextEditingController();
    _customFocusNode = FocusNode();
    _customFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  void dispose() {
    _customFocusNode.removeListener(_onFocusChange);
    _customFocusNode.dispose();
    _customController.dispose();
    super.dispose();
  }

  String _getDynamicText(String original, double percentage) {
    final pctString = percentage.toInt().toString();
    String text = original.replaceAll('20%', '$pctString%');
    text = text.replaceAll('٢٠٪', '$pctString٪');
    return text;
  }

  Widget _buildPercentageOption(double percentage, WelcomeState state) {
    final theme = context.theme;
    final isSelected =
        !_isCustomSelected && state.savingsPercentage == percentage;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isCustomSelected = false;
          });
          context.read<WelcomeCubit>().setSavingsPercentage(percentage);
          _customFocusNode.unfocus();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 46.h,
          decoration: BoxDecoration(
            color: isSelected ? theme.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected
                  ? theme.primaryColor
                  : theme.dividerColor.withOpacity(0.15),
              width: 1.5.w,
            ),
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: theme.primaryColor.withOpacity(0.15),
                  blurRadius: 10.r,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: Center(
            child: Text(
              '${percentage.toInt()}%',
              style: TextStyle(
                color: isSelected ? Colors.white : theme.hintColor,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomOption(WelcomeState state) {
    final theme = context.theme;
    final isSelected = _isCustomSelected;
    final customLabel = Localizations.localeOf(context).languageCode == 'ar'
        ? 'مخصص'
        : 'Custom';
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isCustomSelected = true;
          });
          _customFocusNode.requestFocus();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 46.h,
          decoration: BoxDecoration(
            color: isSelected ? theme.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected
                  ? theme.primaryColor
                  : theme.dividerColor.withOpacity(0.15),
              width: 1.5.w,
            ),
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: theme.primaryColor.withOpacity(0.15),
                  blurRadius: 10.r,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: Center(
            child: Text(
              customLabel,
              style: TextStyle(
                color: isSelected ? Colors.white : theme.hintColor,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }

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
    final theme = context.theme;
    final bool isActivateEnabled = !_isCustomSelected ||
        (_customController.text.isNotEmpty && (double.tryParse(_customController.text) ?? 0) > 0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  context.local.welcomeTitleActivation,
                  style: context.textTheme.displaySmall?.copyWith(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 8.h),
                Text(
                  _getDynamicText(
                    context.local.welcomeSubTitleActivation,
                    state.savingsPercentage,
                  ),
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.theme.hintColor,
                    fontSize: 15.sp,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 24.h),
                Container(
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: context.emergencyLight,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: context.emergencyColor.withOpacity(0.2),
                    ),
                    boxShadow: [
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
                        width: 48.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: context.emergencyColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('🛡️', style: TextStyle(fontSize: 24.sp)),
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
                                color: context.emergencyDark,
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              _getDynamicText(
                                context.local.emergencyWalletAutoSaveDesc,
                                state.savingsPercentage,
                              ),
                              style: context.textTheme.bodySmall?.copyWith(
                                color: context.emergencyColor,
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
                SizedBox(height: 24.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Localizations.localeOf(context).languageCode == 'ar'
                          ? 'نسبة الادخار التلقائي'
                          : 'AUTO-SAVE RATIO',
                      style: context.textTheme.labelMedium?.copyWith(
                        color: context.theme.hintColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        _buildPercentageOption(5.0, state),
                        SizedBox(width: 8.w),
                        _buildPercentageOption(10.0, state),
                        SizedBox(width: 8.w),
                        _buildPercentageOption(15.0, state),
                        SizedBox(width: 8.w),
                        _buildPercentageOption(20.0, state),
                        SizedBox(width: 8.w),
                        _buildCustomOption(state),
                      ],
                    ),
                    if (_isCustomSelected) ...[
                      SizedBox(height: 16.h),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: context.theme.cardColor,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: _customFocusNode.hasFocus
                                ? context.theme.primaryColor
                                : context.theme.dividerColor.withOpacity(0.08),
                            width: _customFocusNode.hasFocus ? 2.w : 1.5.w,
                          ),
                          boxShadow: [
                            if (_customFocusNode.hasFocus)
                              BoxShadow(
                                color: context.theme.primaryColor.withOpacity(
                                  0.12,
                                ),
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
                            Text(
                              Localizations.localeOf(context).languageCode ==
                                      'ar'
                                  ? 'أدخل النسبة:'
                                  : 'Enter Percentage:',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.theme.hintColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: TextField(
                                focusNode: _customFocusNode,
                                controller: _customController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(2),
                                ],
                                textAlign: TextAlign.end,
                                style: context.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                                decoration: InputDecoration(
                                  hintText: '0',
                                  filled: false,
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  suffixText: ' %',
                                  suffixStyle: context.textTheme.titleMedium
                                      ?.copyWith(
                                        color: context.theme.hintColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                onChanged: (value) {
                                  final pct = double.tryParse(value) ?? 0.0;
                                  context.read<WelcomeCubit>().setSavingsPercentage(pct);
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
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
                  side: WidgetStateProperty.all(
                    BorderSide(
                      color: context.warningColor.withOpacity(0.5),
                      width: 1.5.w,
                    ),
                  ),
                  foregroundColor: WidgetStateProperty.all(context.warningDark),
                ),
                child: Text(
                  context.local.btnMaybeLater,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: ElevatedButton(
                onPressed: isActivateEnabled
                    ? () {
                        context.read<WelcomeCubit>().activateEmergencyWallet();
                        context.read<WelcomeCubit>().nextStep();
                      }
                    : null,
                style: context.theme.elevatedButtonTheme.style?.copyWith(
                  minimumSize: WidgetStateProperty.all(Size.fromHeight(56.h)),
                ),
                child: Text(
                  context.local.btnActivateNow,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
            fontWeight: FontWeight.w300,
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
            color: context.primaryLight,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: context.theme.primaryColor.withOpacity(0.15),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.015),
                blurRadius: 10.r,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: context.theme.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text('💡', style: TextStyle(fontSize: 20.sp)),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  context.local.noSalaryInfo,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.primaryDark,
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
                child: Text(context.local.btnBack),
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
                child: Text(context.local.btnGoToDashboard),
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
