import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Brand
  static const Color primary = Color(0xFF533AFD); // Brand Purple
  static const Color primaryLight = Color(0xFFECEBFE);
  static const Color primaryDark = Color(0xFF3824CC);
  
  // Success / Positive Financial
  static const Color success = Color(0xFF00C48C);
  static const Color successLight = Color(0xFFE0FAF3);
  static const Color successDark = Color(0xFF00916A);
  
  // Warning / Caution
  static const Color warning = Color(0xFFFFB400);
  static const Color warningLight = Color(0xFFFFF6DC);
  static const Color warningDark = Color(0xFFCC8F00);
  
  // Danger / Error
  static const Color danger = Color(0xFFFF3B3B);
  static const Color dangerLight = Color(0xFFFFE9E9);
  static const Color dangerDark = Color(0xFFCC2020);
  
  // Emergency Wallet Identity
  static const Color emergency = Color(0xFFFF6B35);
  static const Color emergencyLight = Color(0xFFFFF0EB);
  static const Color emergencyDark = Color(0xFFCC4A1A);
  
  // Wallet Identity Colors
  static const Color walletCash = Color(0xFF00C48C);
  static const Color walletVisa = Color(0xFF0A6EFF);
  static const Color walletSmart = Color(0xFF9B5CFF);
  static const Color walletEmergency = Color(0xFFFF6B35);
  
  // Neutral / Ink Scale
  static const Color ink900 = Color(0xFF0D0F14); // Body text, primary content
  static const Color ink800 = Color(0xFF1A1D26); // Secondary headings
  static const Color ink700 = Color(0xFF2E3348); // Subheadings, labels
  static const Color ink500 = Color(0xFF6B7280); // Secondary text, metadata
  static const Color ink300 = Color(0xFFB0B8C8); // Borders, dividers, placeholder text
  static const Color ink100 = Color(0xFFE8ECF2); // Input borders, subtle dividers
  static const Color ink50 = Color(0xFFF4F6FA);  // Page background, subtle fills
  
  static const Color white = Color(0xFFFFFFFF);
  
  // Financial State Colors
  static const Color balancePositive = success;
  static const Color balanceZero = ink500;
  static const Color balanceLocked = ink300;
}
