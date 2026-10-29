import 'package:flutter/material.dart';

class Tk {
  static const bgTop = Color(0xFFE9FBF2);
  static const bgBottom = Color(0xFFF4F8F7);
  static const waveA = Color(0xFFA7F3D0);
  static const waveB = Color(0xFF14B8A6);
  static const green = Color(0xFF22C55E);
  static const teal = Color(0xFF14B8A6);
  static const ink = Color(0xFF0F172A);
  static const ink2 = Color(0xFF334155);
  static const muted = Color(0xFF475569);
  static const faint = Color(0xFF64748B);
  static const line = Color(0xFFE2E8F0);
  static const grey = Color(0xFF94A3B8);
  static const deep = Color(0xFF0F3D35);
  static const primary = LinearGradient(colors: [green, teal]);

  static const gCache = [Color(0xFF4ADE80), teal];
  static const gResid = [Color(0xFF2DD4BF), Color(0xFF3B82F6)];
  static const gLogs = [Color(0xFFFB923C), Color(0xFFF43F5E)];
  static const gDupe = [Color(0xFF3B82F6), Color(0xFFA855F7)];
  static const gWa = [Color(0xFF25D366), Color(0xFF128C7E)];
  static const gTg = [Color(0xFF38BDF8), Color(0xFF2563EB)];

  static const font = 'Inter';

  static List<BoxShadow> shadow = [
    BoxShadow(
      color: const Color(0xFF0F766E).withValues(alpha: 0.12),
      offset: const Offset(0, 6),
      blurRadius: 16,
    ),
  ];

  static List<BoxShadow> glow = [
    BoxShadow(
      color: green.withValues(alpha: 0.35),
      offset: const Offset(0, 6),
      blurRadius: 20,
    ),
  ];
}
