import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AppCubit extends HydratedCubit<bool> {
  AppCubit() : super(false);

  void markOnboardingViewed() => emit(true);

  @override
  bool fromJson(Map<String, dynamic> json) => json['onboardingViewed'] as bool? ?? false;

  @override
  Map<String, dynamic> toJson(bool state) => {'onboardingViewed': state};
}
