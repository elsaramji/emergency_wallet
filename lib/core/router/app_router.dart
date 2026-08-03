import 'package:go_router/go_router.dart';
import '../blocs/app_cubit.dart';
import '../di/injection.dart';
import '../services/auth_service.dart';
import 'app_routes.dart';
import '../../features/onboarding/presentation/views/onboarding_view.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/auth/presentation/views/register_view.dart';
import '../../features/auth/presentation/views/forgot_password_view.dart';
import '../../features/welcome/presentation/views/welcome_questions_view.dart';
import '../../features/dashboard/presentation/views/dashboard_view.dart';

import '../../shared/widgets/main_shell_view.dart';
import '../../features/history/presentation/views/history_view.dart';
import '../../features/insights/presentation/views/insights_view.dart';
import '../../features/profile/presentation/views/profile_view.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    redirect: (context, state) {
      final onboardingViewed = getIt<AppCubit>().state.onboardingViewed;
      if (!onboardingViewed) {
        if (state.matchedLocation != AppRoutes.onboarding) {
          return AppRoutes.onboarding;
        }
        return null;
      }
      final isLoggedIn = getIt<AuthService>().currentUser != null;
      if (!isLoggedIn) {
        if (state.matchedLocation != AppRoutes.login &&
            state.matchedLocation != AppRoutes.register &&
            state.matchedLocation != AppRoutes.forgotPassword) {
          return AppRoutes.login;
        }
        return null;
      }
      return null;
    },
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShellView(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: AppRoutes.home,
                builder: (context, state) => const DashboardView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.history,
                name: AppRoutes.history,
                builder: (context, state) => const HistoryView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.insights,
                name: AppRoutes.insights,
                builder: (context, state) => const InsightsView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                name: AppRoutes.profile,
                builder: (context, state) => const ProfileView(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        name: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: AppRoutes.register,
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        name: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordView(),
      ),
      GoRoute(
        path: AppRoutes.welcome,
        name: AppRoutes.welcome,
        builder: (context, state) => const WelcomeQuestionsView(),
      ),
    ],
  );
}
