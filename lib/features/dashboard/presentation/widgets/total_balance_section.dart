import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../states/dashboard_cubit.dart';

class TotalBalanceSection extends StatelessWidget {
  const TotalBalanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.local.homeTotalBalance.toUpperCase(),
            style: context.textTheme.labelMedium?.copyWith(
              color: AppColors.ink500,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 4.h),
          BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, state) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    state.isBalanceVisible ? "12,450" : "••••",
                    style: context.textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    context.local.currencyEGP,
                    style: context.textTheme.headlineMedium?.copyWith(
                      color: AppColors.ink500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
