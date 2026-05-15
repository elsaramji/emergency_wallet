part of 'dashboard_cubit.dart';

class DashboardState {
  final bool isBalanceVisible;

  const DashboardState({this.isBalanceVisible = false}); // Default hidden like in most banking apps, or visible depending on UX? Let's make it visible by default or false. Looking at HTML JS, it toggles from a state. Let's make it false by default.

  DashboardState copyWith({bool? isBalanceVisible}) {
    return DashboardState(
      isBalanceVisible: isBalanceVisible ?? this.isBalanceVisible,
    );
  }
}
