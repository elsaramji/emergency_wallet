import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/font_aws5_icons.dart';
import '../states/dashboard_cubit.dart';

class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: CircleAvatar(
                  radius: 20.r,
                  backgroundColor: AppColors.ink100,
                  backgroundImage: const AssetImage(
                    'assets/images/profile_placeholder.png',
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.local.dashboardWelcome,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: AppColors.ink500,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    context.local.dashboardUserNamePlaceholder,
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ],
          ),
          BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, state) {
              return InkWell(
                onTap: () {
                  context.read<DashboardCubit>().toggleBalanceVisibility();
                },
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.ink100),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.ink900.withOpacity(0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    state.isBalanceVisible
                        ? AwsIcons.eye
                        : AwsIcons.eye_slash,
                    color: AppColors.ink500,
                    size: 20.sp,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
