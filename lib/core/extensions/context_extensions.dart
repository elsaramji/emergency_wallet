import 'package:emergency_wallet/core/localization/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  AppLocalizations get local => AppLocalizations.of(this)!;

  Color get ink100 => const Color(0xFFE8ECF2);
  Color get ink300 => const Color(0xFFB0B8C8);
  Color get textMuted => const Color(0xFF6B7280);
  Color get primaryLight => const Color(0xFFECEBFE);
  Color get cashColor => const Color(0xFF00C48C);
  Color get visaColor => const Color(0xFF0A6EFF);
  Color get smartWalletColor => const Color(0xFF9B5CFF);
  Color get emergencyColor => const Color(0xFFFF6B35);
  Color get emergencyLight => const Color(0xFFFFF0EB);
  Color get emergencyDark => const Color(0xFFCC4A1A);
  Color get primaryDark => const Color(0xFF3824CC);
  Color get warningColor => const Color(0xFFFFB400);
  Color get warningLight => const Color(0xFFFFF6DC);
  Color get warningDark => const Color(0xFFCC8F00);
}
