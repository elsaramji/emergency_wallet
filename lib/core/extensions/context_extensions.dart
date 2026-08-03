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
}
