import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/font_aws5_icons.dart';
import 'history_state.dart';
import 'history_transaction_item.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(const HistoryState()) {
    loadYearlyActivity(state.year);
  }

  void loadYearlyActivity(int year) {
    emit(state.copyWith(status: HistoryStatus.loading));

    try {
      // Simulate API call delay
      final Map<int, int> activities = {};
      if (year == 2026) {
        // May 2026 has 12 operations, April 2026 has 24 operations
        activities[4] = 24; // April
        activities[5] = 12; // May
      }
      
      // Other months and other years default to 0 (No activity/Upcoming)

      emit(state.copyWith(
        status: HistoryStatus.success,
        year: year,
        monthActivities: activities,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HistoryStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void changeYear(int delta) {
    final targetYear = state.year + delta;
    loadYearlyActivity(targetYear);
  }

  void selectMonth(int month) {
    // Only fetch transactions if the month has activity
    final operations = state.monthActivities[month] ?? 0;
    if (operations == 0) return;

    emit(state.copyWith(status: HistoryStatus.loading, selectedMonth: month));

    try {
      final List<HistoryTransactionItem> transactions = [];

      if (state.year == 2026) {
        if (month == 5) {
          // May 2026: 12 operations (simulated with 4 visible in detail list matching UI design)
          transactions.addAll([
            const HistoryTransactionItem(
              id: 'm1',
              title: "McDonald's",
              amount: 245.0,
              isPositive: false,
              categoryName: "Food",
              icon: AwsIcons.utensils,
              iconBgColor: Color(0xFFFFF0EB),
              timeLabel: "02:45 PM - 28/05",
            ),
            const HistoryTransactionItem(
              id: 'm2',
              title: "Monthly Salary",
              amount: 12000.0,
              isPositive: true,
              categoryName: "Salary",
              icon: AwsIcons.money_bill,
              iconBgColor: Color(0xFFE0FAF3),
              timeLabel: "09:00 AM - 27/05",
            ),
            const HistoryTransactionItem(
              id: 'm3',
              title: "Uber Trip",
              amount: 82.0,
              isPositive: false,
              categoryName: "Transport",
              icon: AwsIcons.car,
              iconBgColor: Color(0xFFE8F1FF),
              timeLabel: "06:15 PM - 26/05",
            ),
            const HistoryTransactionItem(
              id: 'm4',
              title: "Supermarket",
              amount: 1200.0,
              isPositive: false,
              categoryName: "Shopping",
              icon: AwsIcons.shopping_cart,
              iconBgColor: Color(0xFFFFF0EB), // Light orange matching food/shopping
              timeLabel: "01:30 PM - 25/05",
            ),
          ]);
        } else if (month == 4) {
          // April 2026: 24 operations
          transactions.addAll([
            const HistoryTransactionItem(
              id: 'a1',
              title: "Monthly Rent",
              amount: 3500.0,
              isPositive: false,
              categoryName: "Others",
              icon: AwsIcons.home,
              iconBgColor: Color(0xFFF1F3F5),
              timeLabel: "09:00 AM - 30/04",
            ),
            const HistoryTransactionItem(
              id: 'a2',
              title: "Starbucks Coffee",
              amount: 110.0,
              isPositive: false,
              categoryName: "Food",
              icon: AwsIcons.utensils,
              iconBgColor: Color(0xFFFFF0EB),
              timeLabel: "08:30 AM - 28/04",
            ),
            const HistoryTransactionItem(
              id: 'a3',
              title: "Freelance Design Payment",
              amount: 4500.0,
              isPositive: true,
              categoryName: "Salary",
              icon: AwsIcons.money_bill,
              iconBgColor: Color(0xFFE0FAF3),
              timeLabel: "11:15 AM - 25/04",
            ),
            const HistoryTransactionItem(
              id: 'a4',
              title: "Amazon Egypt",
              amount: 670.0,
              isPositive: false,
              categoryName: "Shopping",
              icon: AwsIcons.shopping_bag,
              iconBgColor: Color(0xFFECEBFE),
              timeLabel: "02:00 PM - 22/04",
            ),
            const HistoryTransactionItem(
              id: 'a5',
              title: "Gym Membership",
              amount: 800.0,
              isPositive: false,
              categoryName: "Health",
              icon: AwsIcons.medkit,
              iconBgColor: Color(0xFFE6FCF5),
              timeLabel: "06:30 AM - 15/04",
            ),
            const HistoryTransactionItem(
              id: 'a6',
              title: "Netflix Subscription",
              amount: 165.0,
              isPositive: false,
              categoryName: "Entertainment",
              icon: AwsIcons.gamepad,
              iconBgColor: Color(0xFFFFF0F5),
              timeLabel: "08:00 PM - 12/04",
            ),
            const HistoryTransactionItem(
              id: 'a7',
              title: "Car Refuel",
              amount: 250.0,
              isPositive: false,
              categoryName: "Transport",
              icon: AwsIcons.car,
              iconBgColor: Color(0xFFE8F1FF),
              timeLabel: "04:45 PM - 10/04",
            ),
          ]);
        }
      }

      emit(state.copyWith(
        status: HistoryStatus.success,
        selectedMonth: month,
        selectedMonthTransactions: transactions,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HistoryStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void clearSelectedMonth() {
    emit(state.copyWith(
      status: HistoryStatus.success,
      selectedMonth: null,
      selectedMonthTransactions: [],
    ));
  }

  void toggleBalanceVisibility() {
    emit(state.copyWith(isBalanceVisible: !state.isBalanceVisible));
  }
}
