import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../states/auth_state.dart';
import '../states/register_cubit.dart';
import '../widgets/custom_text_field.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: const RegisterViewBody(),
    );
  }
}

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRegister() {
    if (_formKey.currentState!.validate()) {
      context.read<RegisterCubit>().register(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<RegisterCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.local.successRegister)),
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
                    SizedBox(height: 24.h),
                    Text(context.local.registerTitle, style: AppTextStyles.h1),
                    SizedBox(height: 8.h),
                    Text(
                      context.local.registerSubtitle,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.ink500,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    CustomTextField(
                      label: context.local.registerNameLabel,
                      hintText: context.local.registerNameHint,
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return context.local.registerNameHint;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.h),
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
                      label: context.local.registerPasswordLabel,
                      hintText: context.local.registerPasswordHint,
                      controller: _passwordController,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return context.local.registerPasswordHint;
                        }
                        if (value.length < 6) {
                          return context.local.errorInvalidPassword;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 40.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state is AuthLoading ? null : _onRegister,
                        child: state is AuthLoading
                            ? SizedBox(
                                height: 24.r,
                                width: 24.r,
                                child: const CircularProgressIndicator(
                                  color: AppColors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(context.local.registerButton),
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.local.alreadyHaveAnAccount,
                          style: AppTextStyles.bodyMedium,
                        ),
                        TextButton(
                          onPressed: () => context.goNamed(AppRoutes.login),
                          child: Text(context.local.loginButton),
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
