import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

class AppState {
  final bool onboardingViewed;
  final String? locale;

  const AppState({
    required this.onboardingViewed,
    this.locale,
  });

  AppState copyWith({
    bool? onboardingViewed,
    String? locale,
  }) {
    return AppState(
      onboardingViewed: onboardingViewed ?? this.onboardingViewed,
      locale: locale ?? this.locale,
    );
  }

  Map<String, dynamic> toJson() => {
        'onboardingViewed': onboardingViewed,
        'locale': locale,
      };

  factory AppState.fromJson(Map<String, dynamic> json) => AppState(
        onboardingViewed: json['onboardingViewed'] as bool? ?? false,
        locale: json['locale'] as String?,
      );
}

@LazySingleton()
class AppCubit extends HydratedCubit<AppState> {
  AppCubit() : super(const AppState(onboardingViewed: false));

  void markOnboardingViewed() => emit(state.copyWith(onboardingViewed: true));

  void changeLocale(String localeCode) => emit(state.copyWith(locale: localeCode));

  @override
  AppState fromJson(Map<String, dynamic> json) => AppState.fromJson(json);

  @override
  Map<String, dynamic> toJson(AppState state) => state.toJson();
}
