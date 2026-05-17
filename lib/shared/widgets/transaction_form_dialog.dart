import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/extensions/context_extensions.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/font_aws5_icons.dart';
import '../../features/dashboard/presentation/states/dashboard_cubit.dart';

class TransactionFormDialog extends StatefulWidget {
  final bool isCashIn;
  final DashboardCubit dashboardCubit;

  const TransactionFormDialog({
    super.key,
    required this.isCashIn,
    required this.dashboardCubit,
  });

  @override
  State<TransactionFormDialog> createState() => _TransactionFormDialogState();
}

class _TransactionFormDialogState extends State<TransactionFormDialog> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  String? _selectedCategoryId;
  String? _selectedWalletId = 'walletCash'; // Default to Cash

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = widget.isCashIn ? AppColors.success : AppColors.primary;

    final categories = widget.isCashIn
        ? [
            {
              'id': 'catSalary',
              'icon': AwsIcons.money_bill,
              'name': context.local.catSalary,
            },
            {
              'id': 'catDeposit',
              'icon': AwsIcons.piggy_bank,
              'name': context.local.catDeposit,
            },
            {
              'id': 'catDebts',
              'icon': AwsIcons.handshake,
              'name': context.local.catDebts,
            },
            {
              'id': 'catFees',
              'icon': AwsIcons.percentage,
              'name': context.local.catFees,
            },
            {
              'id': 'catKPIs',
              'icon': AwsIcons.chart_line,
              'name': context.local.catKPIs,
            },
            {
              'id': 'catOthers',
              'icon': AwsIcons.ellipsis_h,
              'name': context.local.catOthers,
            },
          ]
        : [
            {
              'id': 'catCredits',
              'icon': AwsIcons.hand_holding_usd,
              'name': context.local.catCredits,
            },
            {
              'id': 'catDebts',
              'icon': AwsIcons.handshake,
              'name': context.local.catDebts,
            },
            {
              'id': 'catFees',
              'icon': AwsIcons.percentage,
              'name': context.local.catFees,
            },
            {
              'id': 'catFood',
              'icon': AwsIcons.utensils,
              'name': context.local.catFood,
            },
            {
              'id': 'catTransport',
              'icon': AwsIcons.car,
              'name': context.local.catTransport,
            },
            {
              'id': 'catShopping',
              'icon': AwsIcons.shopping_bag,
              'name': context.local.catShopping,
            },
            {
              'id': 'catHealth',
              'icon': AwsIcons.medkit,
              'name': context.local.catHealth,
            },
            {
              'id': 'catEntertainment',
              'icon': AwsIcons.gamepad,
              'name': context.local.catEntertainment,
            },
            {
              'id': 'catOthers',
              'icon': AwsIcons.ellipsis_h,
              'name': context.local.catOthers,
            },
          ];

    return BlocBuilder<DashboardCubit, DashboardState>(
      bloc: widget.dashboardCubit,
      builder: (context, state) {
        final activeBalancesSum = state.cashBalance + state.visaBalance + state.smartWalletBalance;
        final isEmergencyLocked = !widget.isCashIn && (activeBalancesSum >= 50.0);

        // If emergency is locked and was currently selected, reset selection to Cash
        if (isEmergencyLocked && _selectedWalletId == 'walletEmergency') {
          _selectedWalletId = 'walletCash';
        }

        final wallets = [
          {
            'id': 'walletCash',
            'icon': AwsIcons.coins,
            'name': context.local.homeCash,
            'color': const Color(0xFF00C48C),
          },
          {
            'id': 'walletVisa',
            'icon': AwsIcons.credit_card,
            'name': context.local.homeVisa,
            'color': const Color(0xFF533AFD),
          },
          {
            'id': 'walletSmart',
            'icon': AwsIcons.wallet,
            'name': context.local.homeSmartWallet,
            'color': const Color(0xFF9B5CFF),
          },
          {
            'id': 'walletEmergency',
            'icon': AwsIcons.shield_alt,
            'name': context.local.homeEmergency,
            'color': const Color(0xFFFF6B35),
            'locked': isEmergencyLocked,
          },
        ];

        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.isCashIn ? context.local.cashIn : context.local.cashOut,
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink900,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Amount Input
                  Text(
                    context.local.amountLabel,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: AppColors.ink500,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    style: context.textTheme.headlineMedium?.copyWith(
                      color: themeColor,
                      fontWeight: FontWeight.w700,
                    ),
                    decoration: InputDecoration(
                      hintText: "0.00",
                      suffixText: context.local.currencyEGP,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: const BorderSide(color: AppColors.ink100),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: const BorderSide(color: AppColors.ink100),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide(color: themeColor, width: 2),
                      ),
                      filled: true,
                      fillColor: AppColors.ink50,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Wallet Selection
                  Text(
                    context.local.walletLabel,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: AppColors.ink500,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: wallets.map((w) {
                      final isSelected = _selectedWalletId == w['id'];
                      final isLocked = w['locked'] as bool? ?? false;
                      final walletColor = w['color'] as Color;

                      return Opacity(
                        opacity: isLocked ? 0.6 : 1.0,
                        child: ChoiceChip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isLocked ? AwsIcons.lock : w['icon'] as IconData,
                                size: 14.sp,
                                color: isSelected
                                    ? Colors.white
                                    : (isLocked ? AppColors.ink500 : AppColors.ink700),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                w['name'] as String,
                                style: TextStyle(
                                  decoration: isLocked ? TextDecoration.lineThrough : null,
                                ),
                              ),
                            ],
                          ),
                          selected: isSelected && !isLocked,
                          onSelected: isLocked
                              ? null
                              : (selected) {
                                  setState(() {
                                    _selectedWalletId = selected
                                        ? (w['id'] as String)
                                        : null;
                                  });
                                },
                          selectedColor: walletColor,
                          backgroundColor: AppColors.white,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : (isLocked ? AppColors.ink500 : AppColors.ink700),
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 8.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            side: BorderSide(
                              color: isSelected
                                  ? walletColor
                                  : (isLocked ? AppColors.ink300 : AppColors.ink100),
                            ),
                          ),
                          showCheckmark: false,
                        ),
                      );
                    }).toList(),
                  ),
                  if (isEmergencyLocked) ...[
                    SizedBox(height: 8.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          AwsIcons.info_circle,
                          size: 14.sp,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            context.local.emergencyWalletLockedWarning,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: AppColors.primary,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  SizedBox(height: 24.h),

                  // Category Selection
                  Text(
                    context.local.categoryLabel,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: AppColors.ink500,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: categories.map((cat) {
                      final isSelected = _selectedCategoryId == cat['id'];
                      return ChoiceChip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              cat['icon'] as IconData,
                              size: 14.sp,
                              color: isSelected ? Colors.white : AppColors.ink700,
                            ),
                            SizedBox(width: 6.w),
                            Text(cat['name'] as String),
                          ],
                        ),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedCategoryId = selected
                                ? (cat['id'] as String)
                                : null;
                          });
                        },
                        selectedColor: themeColor,
                        backgroundColor: AppColors.white,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : AppColors.ink700,
                          fontWeight: FontWeight.w600,
                          fontSize: 13.sp,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          side: BorderSide(
                            color: isSelected ? themeColor : AppColors.ink100,
                          ),
                        ),
                        showCheckmark: false,
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 24.h),

                  // Note Input
                  Text(
                    context.local.noteLabel,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: AppColors.ink500,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextField(
                    controller: _noteController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Add a note...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: const BorderSide(color: AppColors.ink100),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: const BorderSide(color: AppColors.ink100),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide(color: themeColor, width: 2),
                      ),
                      filled: true,
                      fillColor: AppColors.ink50,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Simulator Switch
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColors.ink50,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.ink100),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              AwsIcons.flask,
                              size: 16.sp,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              context.local.simulateLowBalance,
                              style: context.textTheme.bodySmall?.copyWith(
                                color: AppColors.ink800,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                        Switch.adaptive(
                          value: state.isLowBalanceSimulated,
                          onChanged: (val) {
                            widget.dashboardCubit.toggleLowBalanceSimulation();
                          },
                          activeThumbColor: AppColors.primary,
                          activeTrackColor: AppColors.primaryLight,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            context.local.cancel,
                            style: TextStyle(
                              color: AppColors.ink500,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Implement submission logic
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: themeColor,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            context.local.addTransaction,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
