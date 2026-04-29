import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../states/auth_state.dart';
import '../states/login_cubit.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/social_auth_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const LoginViewBody(),
    );
  }
}

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<LoginCubit>().loginWithEmail(
        _emailController.text,
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<LoginCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.local.successLogin)),
              );
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40.h),
                    Text(context.local.loginWelcome, style: AppTextStyles.h1),
                    SizedBox(height: 8.h),
                    Text(
                      context.local.loginSubtitle,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.ink500,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    CustomTextField(
                      label: context.local.emailLabel,
                      hintText: context.local.emailHint,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return context.local.emailHint;
                        }
                        if (!value.contains('@')) {
                          return context.local.errorInvalidEmail;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.h),
                    CustomTextField(
                      label: context.local.passwordLabel,
                      hintText: context.local.passwordHint,
                      controller: _passwordController,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return context.local.passwordHint;
                        }
                        if (value.length < 6) {
                          return context.local.errorInvalidPassword;
                        }
                        return null;
                      },
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextButton(
                        onPressed: () => context.pushNamed(AppRoutes.forgotPassword),
                        child: Text(
                          context.local.forgotPassword,
                          style: AppTextStyles.labelMedium.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state is AuthLoading ? null : _onLogin,
                        child: state is AuthLoading
                            ? SizedBox(
                                height: 24.r,
                                width: 24.r,
                                child: const CircularProgressIndicator(
                                  color: AppColors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(context.local.loginButton),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            context.local.or,
                            style: AppTextStyles.caption,
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    SocialAuthButton(
                      text: context.local.continueWithGoogle,
                      icon: Icons.g_mobiledata,
                      onPressed: state is AuthLoading
                          ? () {}
                          : () => context.read<LoginCubit>().loginWithGoogle(),
                    ),
                    SizedBox(height: 32.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.local.donTHaveAnAccount,
                          style: AppTextStyles.bodyMedium,
                        ),
                        TextButton(
                          onPressed: () => context.goNamed(AppRoutes.register),
                          child: Text(context.local.registerButton),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
