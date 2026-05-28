import 'package:flutter/widgets.dart';

class HistoryTransactionItem {
  final String id;
  final String title;
  final double amount;
  final bool isPositive;
  final String categoryName;
  final IconData icon;
  final Color iconBgColor;
  final String timeLabel;

  const HistoryTransactionItem({
    required this.id,
    required this.title,
    required this.amount,
    required this.isPositive,
    required this.categoryName,
    required this.icon,
    required this.iconBgColor,
    required this.timeLabel,
  });
}
