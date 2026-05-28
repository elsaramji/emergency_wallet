import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';

class MonthGridWidget extends StatelessWidget {
  final int selectedYear;
  final Map<int, int> monthActivities;
  final int? selectedMonth;
  final ValueChanged<int> onMonthSelected;

  const MonthGridWidget({
    super.key,
    required this.selectedYear,
    required this.monthActivities,
    required this.selectedMonth,
    required this.onMonthSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Current simulated date is May 2026
    const int currentSimulatedYear = 2026;
    const int currentSimulatedMonth = 5;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 1.0,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        final int month = index + 1;
        final int operationsCount = monthActivities[month] ?? 0;
        final bool hasActivity = operationsCount > 0;

        // Check if month is upcoming relative to May 2026
        final bool isUpcoming = (selectedYear > currentSimulatedYear) ||
            (selectedYear == currentSimulatedYear && month > currentSimulatedMonth);

        return _MonthCard(
          month: month,
          year: selectedYear,
          operationsCount: operationsCount,
          hasActivity: hasActivity,
          isUpcoming: isUpcoming,
          isSelected: selectedMonth == month,
          onTap: () {
            if (hasActivity) {
              onMonthSelected(month);
            }
          },
        );
      },
    );
  }
}

class _MonthCard extends StatelessWidget {
  final int month;
  final int year;
  final int operationsCount;
  final bool hasActivity;
  final bool isUpcoming;
  final bool isSelected;
  final VoidCallback onTap;

  const _MonthCard({
    required this.month,
    required this.year,
    required this.operationsCount,
    required this.hasActivity,
    required this.isUpcoming,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Get month name dynamically using DateFormat
    final String locale = Localizations.localeOf(context).toString();
    final String monthName = DateFormat.MMM(locale).format(DateTime(year, month));

    // Get operations label
    String opsLabel;
    if (isUpcoming) {
      opsLabel = context.local.historyUpcoming;
    } else if (hasActivity) {
      opsLabel = operationsCount == 1
          ? "1 ${context.local.historyOperations}"
          : "$operationsCount ${context.local.historyOperations}";
    } else {
      opsLabel = context.local.historyNoActivity;
    }

    final bool isClickable = hasActivity && !isUpcoming;

    return InkWell(
      onTap: isClickable ? onTap : null,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        decoration: BoxDecoration(
          color: isUpcoming ? const Color(0xFFF8FAFC) : AppColors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected
                ? context.colorScheme.primary
                : AppColors.ink100.withOpacity(0.5),
            width: isSelected ? 2.w : 1.5.w,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.ink900.withOpacity(isUpcoming ? 0.01 : 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Opacity(
          opacity: (isUpcoming || !hasActivity) ? 0.6 : 1.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                monthName,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  color: AppColors.ink900,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                opsLabel,
                style: context.textTheme.labelSmall?.copyWith(
                  fontSize: 11.sp,
                  color: AppColors.ink500,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (hasActivity && !isUpcoming) ...[
                SizedBox(height: 6.h),
                Container(
                  width: 6.w,
                  height: 6.w,
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
