import 'package:flutter/material.dart';
import 'package:tidyo/Core/Theme/AppTokens.dart';
import 'package:tidyo/Core/Widgets/Canvas360Widget.dart';
import 'package:tidyo/Core/Widgets/BottomPillNavWidget.dart';
import 'package:tidyo/Core/Widgets/SvgIconWidget.dart';

class SettingsScreen extends StatefulWidget {
  final ValueChanged<int> onNavTap;

  const SettingsScreen({
    super.key,
    required this.onNavTap,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _quarantineEnabled = true;
  bool _autoScanLowStorage = true;
  bool _notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Canvas360(
      waveH: 220,
      children: [
        tx(24, 82, 'Settings', 26, w: FontWeight.w800),
        tx(24, 106, 'Preferences & Safe Quarantine', 14, c: Tk.deep),

        // Section 1: Protection & Quarantine
        card(16, 140, 328, 148, r: 24),
        Positioned(
          left: 32,
          top: 156,
          child: const SvgIcon('lock', size: 20, color: Tk.teal),
        ),
        tx(64, 172, 'Safety & Quarantine', 15, w: FontWeight.w700),
        tx(32, 206, '3-Tier Quarantine Protection', 13, w: FontWeight.w600),
        tx(32, 222, 'Never delete user photos, docs or media', 11, c: Tk.faint),
        Positioned(
          right: 28,
          top: 194,
          child: Switch.adaptive(
            value: _quarantineEnabled,
            activeTrackColor: Tk.green, activeThumbColor: Colors.white,
            onChanged: (val) => setState(() => _quarantineEnabled = val),
          ),
        ),
        box(32, 240, 296, 1, r: 0, color: Tk.line),
        tx(32, 260, 'Protected Whitelist', 13, w: FontWeight.w600),
        tx(32, 274, '6 system directories excluded', 11, c: Tk.faint),
        Positioned(
          right: 28,
          top: 254,
          child: const SvgIcon('chevron', size: 16, color: Tk.grey),
        ),

        // Section 2: Automation & Storage
        card(16, 304, 328, 144, r: 24),
        Positioned(
          left: 32,
          top: 320,
          child: const SvgIcon('gear', size: 20, color: Tk.teal),
        ),
        tx(64, 336, 'Automations', 15, w: FontWeight.w700),
        tx(32, 370, 'Low Storage Alerts (<15% free)', 13, w: FontWeight.w600),
        tx(32, 386, 'Suggest cleaning when disk space is low', 11, c: Tk.faint),
        Positioned(
          right: 28,
          top: 358,
          child: Switch.adaptive(
            value: _autoScanLowStorage,
            activeTrackColor: Tk.green, activeThumbColor: Colors.white,
            onChanged: (val) => setState(() => _autoScanLowStorage = val),
          ),
        ),
        box(32, 404, 296, 1, r: 0, color: Tk.line),
        tx(32, 424, 'Periodic Cleanup Reminders', 13, w: FontWeight.w600),
        tx(32, 438, 'Notify once a week if junk > 1 GB', 11, c: Tk.faint),
        Positioned(
          right: 28,
          top: 418,
          child: Switch.adaptive(
            value: _notificationsEnabled,
            activeTrackColor: Tk.green, activeThumbColor: Colors.white,
            onChanged: (val) => setState(() => _notificationsEnabled = val),
          ),
        ),

        // Section 3: Open Source & About
        card(16, 464, 328, 170, r: 24),
        Positioned(
          left: 32,
          top: 480,
          child: const SvgIcon('spark', size: 20, color: Tk.teal),
        ),
        tx(64, 496, 'About Tidyo', 15, w: FontWeight.w700),
        box(256, 478, 72, 22, r: 11, color: const Color(0xFFD1FAE5)),
        tx(292, 493, 'v1.0.0', 10, w: FontWeight.w700, c: const Color(0xFF065F46), a: TextAlign.center),
        tx(32, 530, '100% Free & Open-Source Mobile Cleaner', 13, w: FontWeight.w600),
        tx(32, 546, 'MIT License · Zero Ads · Zero Trackers · Privacy First', 11, c: Tk.faint),
        box(32, 564, 296, 1, r: 0, color: Tk.line),
        tx(32, 584, 'GitHub Repository', 13, w: FontWeight.w600),
        tx(32, 598, 'github.com/Fardin7798/Tidyo', 11, c: const Color(0xFF0F766E)),
        Positioned(
          right: 28,
          top: 580,
          child: const SvgIcon('chevron', size: 16, color: Tk.grey),
        ),
        box(32, 616, 296, 1, r: 0, color: Tk.line),
        tx(180, 628, 'Made with ❤️ for genuine storage recovery', 11, w: FontWeight.w600, c: Tk.muted, a: TextAlign.center),

        // Bottom Navigation Bar
        nav(3, onTap: widget.onNavTap),
      ],
    );
  }
}
