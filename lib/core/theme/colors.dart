import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF4361EE);
  static const Color secondary = Color(0xFF3A0CA3);
  static const Color accent = Color(0xFF4CC9F0);
  
  // Weather Colors
  static const Color sunny = Color(0xFFFFB347);
  static const Color cloudy = Color(0xFFB0BEC5);
  static const Color rainy = Color(0xFF64B5F6);
  static const Color stormy = Color(0xFF37474F);
  
  // UI Colors
  static const Color background = Color(0xFF0A0E21);
  static const Color cardBackground = Color(0xFF1D1E33);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF8D8E98);
  
  // Gradient Colors
  static const Gradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, secondary],
  );
  
  static const Gradient sunnyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF9A00), Color(0xFFFF6B00)],
  );
  
  static const Gradient cloudyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFB0BEC5), Color(0xFF78909C)],
  );
  
  static const Gradient rainyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF64B5F6), Color(0xFF1976D2)],
  );
}