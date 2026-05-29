import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/font_aws5_icons.dart';
import '../states/history_cubit.dart';
import '../states/history_state.dart';
import '../states/history_transaction_item.dart';

class TransactionBottomSheet extends StatefulWidget {
  final int month;
  final int year;

  const TransactionBottomSheet({
    super.key,
    required this.month,
    required this.year,
  });

  @override
  State<TransactionBottomSheet> createState() => _TransactionBottomSheetState();
}

class _TransactionBottomSheetState extends State<TransactionBottomSheet> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String locale = Localizations.localeOf(context).toString();
    final String monthName = DateFormat.MMMM(
      locale,
    ).format(DateTime(widget.year, widget.month));
    final String titleText = "$monthName ${widget.year}";

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColors.ink100,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 24.h),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titleText,
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  color: AppColors.ink900,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<HistoryCubit, HistoryState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          context
                              .read<HistoryCubit>()
                              .toggleBalanceVisibility();
                        },
                        child: Icon(
                          state.isBalanceVisible
                              ? AwsIcons.eye
                              : AwsIcons.eye_slash,
                          size: 20.sp,
                          color: AppColors.ink500,
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 16.w),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      AwsIcons.times,
                      size: 20.sp,
                      color: AppColors.ink500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Category selection (Cash Out / Cash In)
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppColors.ink50,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: _currentIndex == 0
                            ? AppColors.white
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: _currentIndex == 0
                            ? [
                                BoxShadow(
                                  color: AppColors.ink900.withOpacity(0.05),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        context.local.cashOut,
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: _currentIndex == 0
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: _currentIndex == 0
                              ? AppColors.primary
                              : AppColors.ink500,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 320),
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: _currentIndex == 1
                            ? AppColors.white
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: _currentIndex == 1
                            ? [
                                BoxShadow(
                                  color: AppColors.ink900.withOpacity(0.05),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        context.local.cashIn,
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: _currentIndex == 1
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: _currentIndex == 1
                              ? AppColors.primary
                              : AppColors.ink500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Transactions List (using PageView for smooth horizontal swipe navigation)
          SizedBox(
            height: 320.h,
            child: BlocBuilder<HistoryCubit, HistoryState>(
              builder: (context, state) {
                if (state.status == HistoryStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                final cashOutTransactions = state.selectedMonthTransactions
                    .where((item) => !item.isPositive)
                    .toList();

                final cashInTransactions = state.selectedMonthTransactions
                    .where((item) => item.isPositive)
                    .toList();

                Widget buildTransactionList(
                  List<HistoryTransactionItem> transactions,
                ) {
                  if (transactions.isEmpty) {
                    return Center(
                      child: Text(
                        context.local.historyNoActivity,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: AppColors.ink500,
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 24.h),
                    itemCount: transactions.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final item = transactions[index];
                      return _TransactionItemMini(item: item);
                    },
                  );
                }

                return PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  children: [
                    buildTransactionList(cashOutTransactions),
                    buildTransactionList(cashInTransactions),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionItemMini extends StatelessWidget {
  final HistoryTransactionItem item;

  const _TransactionItemMini({required this.item});

  @override
  Widget build(BuildContext context) {
    final currency = context.local.currencyEGP;
    final amountSign = item.isPositive ? "+" : "-";
    final amountText = "$amountSign${item.amount.toStringAsFixed(0)} $currency";

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.ink50,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          // Icon Container
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: item.iconBgColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            alignment: Alignment.center,
            child: Icon(
              item.icon,
              color: item.isPositive
                  ? AppColors.successDark
                  : AppColors.primaryDark,
              size: 16.sp,
            ),
          ),
          SizedBox(width: 12.w),

          // Title & Date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColors.ink900,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  item.timeLabel,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 11.sp,
                    color: AppColors.ink500,
                  ),
                ),
              ],
            ),
          ),

          // Amount
          BlocBuilder<HistoryCubit, HistoryState>(
            builder: (context, state) {
              return Text(
                state.isBalanceVisible ? amountText : "••••",
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                  color: item.isPositive ? AppColors.success : AppColors.ink900,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
