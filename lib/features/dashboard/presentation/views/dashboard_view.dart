import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/dashboard_app_bar.dart';
import '../widgets/quick_actions.dart';
import '../widgets/recent_activity_section.dart';
import '../widgets/total_balance_section.dart';
import '../widgets/wallets_grid.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF2F6), // Matches design background
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              DashboardAppBar(),
              TotalBalanceSection(),
              WalletsGrid(),
              QuickActions(),
              RecentActivitySection(),
            ],
          ),
        ),
      ),
    );
  }
}
