import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(const DashboardState(isBalanceVisible: false));

  void toggleBalanceVisibility() {
    emit(state.copyWith(isBalanceVisible: !state.isBalanceVisible));
  }

  void toggleLowBalanceSimulation() {
    if (state.isLowBalanceSimulated) {
      emit(state.copyWith(
        isLowBalanceSimulated: false,
        cashBalance: 4200.0,
        visaBalance: 6800.0,
        smartWalletBalance: 1450.0,
      ));
    } else {
      emit(state.copyWith(
        isLowBalanceSimulated: true,
        cashBalance: 15.0,
        visaBalance: 15.0,
        smartWalletBalance: 10.0,
      ));
    }
  }
}
