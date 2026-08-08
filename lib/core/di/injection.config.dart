// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i107;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/presentation/states/login_cubit.dart' as _i965;
import '../../features/auth/presentation/states/register_cubit.dart' as _i15;
import '../../features/profile/data/datasources/profile_remote_data_source.dart'
    as _i800;
import '../../features/profile/data/repositories/profile_repository_impl.dart'
    as _i801;
import '../../features/profile/domain/repositories/profile_repository.dart'
    as _i802;
import '../../features/welcome/domain/usecases/complete_onboarding_usecase.dart'
    as _i803;
import '../../features/welcome/presentation/states/welcome_cubit.dart'
    as _i804;
import '../blocs/app_cubit.dart' as _i782;
import '../services/auth_service.dart' as _i745;
import '../services/firestore_service.dart' as _i52;
import 'firebase_module.dart' as _i616;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final firebaseModule = _$FirebaseModule();
    gh.lazySingleton<_i782.AppCubit>(() => _i782.AppCubit());
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
    gh.lazySingleton<_i116.GoogleSignIn>(() => firebaseModule.googleSignIn);
    gh.lazySingleton<_i107.AuthRemoteDataSource>(
      () => _i107.AuthRemoteDataSourceImpl(
        gh<_i59.FirebaseAuth>(),
        gh<_i974.FirebaseFirestore>(),
        gh<_i116.GoogleSignIn>(),
      ),
    );
    gh.lazySingleton<_i745.AuthService>(
      () => _i745.AuthService(
        firebaseAuth: gh<_i59.FirebaseAuth>(),
        googleSignIn: gh<_i116.GoogleSignIn>(),
      ),
    );
    gh.lazySingleton<_i52.FirestoreService>(
      () => _i52.FirestoreService(firestore: gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(gh<_i107.AuthRemoteDataSource>()),
    );
    gh.lazySingleton<_i800.ProfileRemoteDataSource>(
      () => _i800.ProfileRemoteDataSourceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i802.ProfileRepository>(
      () => _i801.ProfileRepositoryImpl(gh<_i800.ProfileRemoteDataSource>()),
    );
    gh.factory<_i803.CompleteOnboardingUseCase>(
      () => _i803.CompleteOnboardingUseCase(
        authRepository: gh<_i787.AuthRepository>(),
        profileRepository: gh<_i802.ProfileRepository>(),
      ),
    );
    gh.factory<_i804.WelcomeCubit>(
      () => _i804.WelcomeCubit(gh<_i803.CompleteOnboardingUseCase>()),
    );
    gh.lazySingleton<_i965.LoginCubit>(
      () => _i965.LoginCubit(gh<_i787.AuthRepository>()),
    );
    gh.lazySingleton<_i15.RegisterCubit>(
      () => _i15.RegisterCubit(gh<_i787.AuthRepository>()),
    );
    return this;
  }
}

class _$FirebaseModule extends _i616.FirebaseModule {}
