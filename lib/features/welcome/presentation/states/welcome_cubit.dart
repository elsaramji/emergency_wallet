import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/complete_onboarding_usecase.dart';
import 'welcome_state.dart';

@injectable
class WelcomeCubit extends Cubit<WelcomeState> {
  final CompleteOnboardingUseCase _completeOnboardingUseCase;

  WelcomeCubit(this._completeOnboardingUseCase) : super(const WelcomeState());

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
    emit(state.copyWith(currentStep: nextStep));
  }

  void previousStep() {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  Future<void> completeSurvey() async {
    emit(state.copyWith(status: WelcomeStatus.loading));

    final params = CompleteOnboardingParams(
      employmentStatus: state.employmentType?.name ?? 'employee',
      hasStableSalary: state.hasStableSalary ?? false,
      monthlySalary: state.salaryAmount,
      emergencyWalletActivated:
          state.emergencyWalletStatus == EmergencyWalletStatus.accepted,
      initialCashBalance: state.cashBalance ?? 0.0,
      initialVisaBalance: state.visaBalance ?? 0.0,
      initialSmartWalletBalance: state.smartWalletBalance ?? 0.0,
    );

    final result = await _completeOnboardingUseCase(params);
    result.fold(
      (failure) => emit(state.copyWith(
        status: WelcomeStatus.failure,
        errorMessage: failure.message,
      )),
      (profile) => emit(state.copyWith(
        status: WelcomeStatus.success,
        isCompleted: true,
      )),
    );
  }
}

