import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/utils/font_aws5_icons.dart';

class YearSelector extends StatelessWidget {
  final int year;
  final VoidCallback onPreviousYear;
  final VoidCallback onNextYear;

  const YearSelector({
    super.key,
    required this.year,
    required this.onPreviousYear,
    required this.onNextYear,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onPreviousYear,
          icon: Icon(
            AwsIcons.chevron_left,
            size: 16.sp,
            color: context.colorScheme.onSurface.withOpacity(0.6),
          ),
          padding: EdgeInsets.all(4.w),
          constraints: const BoxConstraints(),
        ),
        SizedBox(width: 8.w),
        Text(
          year.toString(),
          style: context.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
            color: context.colorScheme.onSurface,
          ),
        ),
        SizedBox(width: 8.w),
        IconButton(
          onPressed: onNextYear,
          icon: Icon(
            AwsIcons.chevron_right,
            size: 16.sp,
            color: context.colorScheme.onSurface.withOpacity(0.6),
          ),
          padding: EdgeInsets.all(4.w),
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}
