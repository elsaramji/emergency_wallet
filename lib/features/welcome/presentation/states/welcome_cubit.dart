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

  void setSalaryAmount(double amount) {
    emit(state.copyWith(salaryAmount: amount));
  }

  void setSavingsPercentage(double percentage) {
    emit(state.copyWith(savingsPercentage: percentage));
  }

  void setCashBalance(double balance) {
    emit(state.copyWith(cashBalance: balance));
  }

  void setVisaBalance(double balance) {
    emit(state.copyWith(visaBalance: balance));
  }

  void setSmartWalletBalance(double balance) {
    emit(state.copyWith(smartWalletBalance: balance));
  }

  void nextStep() {
    int nextStep = state.currentStep + 1;
    
    // Jump logic based on salary status
    if (state.currentStep == 1 && state.hasStableSalary == false) {
      // From Salary Question (No) -> Activation Disabled (Step 2 in Non-Salaried flow)
      // Actually, let's keep the step numbers relative to the flow.
      // But for the AnimatedSwitcher, we need unique indices.
    }

    emit(state.copyWith(currentStep: nextStep));
  }

  void previousStep() {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  void completeSurvey() {
    emit(state.copyWith(isCompleted: true));
  }
}
