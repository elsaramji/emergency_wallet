import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/font_aws5_icons.dart';
import '../states/history_cubit.dart';
import '../states/history_state.dart';
import '../widgets/month_grid_widget.dart';
import '../widgets/transaction_bottom_sheet.dart';
import '../widgets/year_selector.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryCubit(),
      child: const _HistoryViewBody(),
    );
  }
}

class _HistoryViewBody extends StatelessWidget {
  const _HistoryViewBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2F6),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              
              // Custom Header: Back button & Year selector
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.go(AppRoutes.home);
                    },
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.ink100.withOpacity(0.5),
                          width: 1.w,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.ink900.withOpacity(0.03),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        AwsIcons.chevron_left,
                        size: 16.sp,
                        color: AppColors.ink900,
                      ),
                    ),
                  ),
                  BlocBuilder<HistoryCubit, HistoryState>(
                    buildWhen: (previous, current) => previous.year != current.year,
                    builder: (context, state) {
                      return YearSelector(
                        year: state.year,
                        onPreviousYear: () {
                          context.read<HistoryCubit>().changeYear(-1);
                        },
                        onNextYear: () {
                          context.read<HistoryCubit>().changeYear(1);
                        },
                      );
                    },
                  ),
                  SizedBox(width: 40.w), // Visual balance for the back button
                ],
              ),
              
              SizedBox(height: 32.h),
              
              // Title & Subtitle
              Text(
                context.local.historyTitle,
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 28.sp,
                  color: AppColors.ink900,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                context.local.historySubtitle,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.ink500,
                ),
              ),
              
              SizedBox(height: 32.h),
              
              // Monthly Calendar Grid
              BlocBuilder<HistoryCubit, HistoryState>(
                buildWhen: (previous, current) =>
                    previous.year != current.year ||
                    previous.monthActivities != current.monthActivities ||
                    previous.selectedMonth != current.selectedMonth,
                builder: (context, state) {
                  return MonthGridWidget(
                    selectedYear: state.year,
                    monthActivities: state.monthActivities,
                    selectedMonth: state.selectedMonth,
                    onMonthSelected: (month) {
                      context.read<HistoryCubit>().selectMonth(month);
                      _showTransactionsBottomSheet(context, month, state.year);
                    },
                  );
                },
              ),
              
              SizedBox(height: 100.h), // padding for bottom nav
            ],
          ),
        ),
      ),
    );
  }

  void _showTransactionsBottomSheet(BuildContext context, int month, int year) {
    final historyCubit = context.read<HistoryCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) {
        return BlocProvider.value(
          value: historyCubit,
          child: TransactionBottomSheet(
            month: month,
            year: year,
          ),
        );
      },
    ).then((_) {
      historyCubit.clearSelectedMonth();
    });
  }
}
