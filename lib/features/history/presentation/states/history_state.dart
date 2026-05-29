import 'history_transaction_item.dart';

enum HistoryStatus { initial, loading, success, failure }

class HistoryState {
  final HistoryStatus status;
  final int year;
  final Map<int, int> monthActivities;
  final int? selectedMonth;
  final List<HistoryTransactionItem> selectedMonthTransactions;
  final String? errorMessage;
  final bool isBalanceVisible;

  const HistoryState({
    this.status = HistoryStatus.initial,
    this.year = 2026,
    this.monthActivities = const {},
    this.selectedMonth,
    this.selectedMonthTransactions = const [],
    this.errorMessage,
    this.isBalanceVisible = false,
  });

  HistoryState copyWith({
    HistoryStatus? status,
    int? year,
    Map<int, int>? monthActivities,
    int? selectedMonth,
    List<HistoryTransactionItem>? selectedMonthTransactions,
    String? errorMessage,
    bool? isBalanceVisible,
  }) {
    return HistoryState(
      status: status ?? this.status,
      year: year ?? this.year,
      monthActivities: monthActivities ?? this.monthActivities,
      selectedMonth: selectedMonth, // Allow setting to null explicitly when closed
      selectedMonthTransactions: selectedMonthTransactions ?? this.selectedMonthTransactions,
      errorMessage: errorMessage ?? this.errorMessage,
      isBalanceVisible: isBalanceVisible ?? this.isBalanceVisible,
    );
  }
}
