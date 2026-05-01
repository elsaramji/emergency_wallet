import 'package:flutter_bloc/flutter_bloc.dart';
import 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit() : super(const WelcomeState());

  void selectEmploymentType(EmploymentType type) {
    emit(state.copyWith(employmentType: type));
  }

  void setStableSalary(bool hasStableSalary) {
    emit(state.copyWith(hasStableSalary: hasStableSalary));
  }

  void activateEmergencyWallet() {
    emit(state.copyWith(emergencyWalletStatus: EmergencyWalletStatus.accepted));
  }

  void declineEmergencyWallet() {
    emit(state.copyWith(emergencyWalletStatus: EmergencyWalletStatus.declined));
  }

  void nextStep() {
    if (state.currentStep < 2) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void previousStep() {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }
}
