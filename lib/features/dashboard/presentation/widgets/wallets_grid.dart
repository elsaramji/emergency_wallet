import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/utils/font_aws5_icons.dart';
import 'wallet_card.dart';

class WalletsGrid extends StatelessWidget {
  const WalletsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 32.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                WalletCard(
                  title: context.local.homeCash,
                  amount: "4,200",
                  icon: AwsIcons.coins,
                  gradientColors: const [Color(0xFF00C48C), Color(0xFF00916A)],
                ),
                SizedBox(height: 16.h),
                WalletCard(
                  title: context.local.homeSmartWallet,
                  amount: "1,450",
                  icon: AwsIcons.wallet,
                  gradientColors: const [Color(0xFF9B5CFF), Color(0xFF7C3AED)],
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              children: [
                WalletCard(
                  title: context.local.homeVisa,
                  amount: "6,800",
                  icon: AwsIcons.credit_card,
                  gradientColors: const [Color(0xFF533AFD), Color(0xFF3824CC)],
                ),
                SizedBox(height: 16.h),
                WalletCard(
                  title: context.local.homeEmergency,
                  amount: "3,500",
                  icon: AwsIcons.shield_alt,
                  gradientColors: const [Color(0xFFFF6B35), Color(0xFFCC4A1A)],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
