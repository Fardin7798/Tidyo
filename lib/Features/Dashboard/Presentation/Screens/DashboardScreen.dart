import 'package:flutter/material.dart';
import 'package:tidyo/Core/Theme/AppTokens.dart';
import 'package:tidyo/Core/Widgets/Canvas360Widget.dart';
import 'package:tidyo/Core/Widgets/BottomPillNavWidget.dart';
import 'package:tidyo/Core/Models/StorageInfoModel.dart';
import 'package:tidyo/Features/AppCache/Presentation/Screens/AppCacheScreen.dart';
import 'package:tidyo/Features/ResidualFiles/Presentation/Screens/ResidualFilesScreen.dart';
import 'package:tidyo/Features/LogsTemp/Presentation/Screens/LogsTempScreen.dart';
import 'package:tidyo/Features/StorageAnalyzer/Presentation/Screens/AnalyzerScreen.dart';

class DashboardScreen extends StatelessWidget {
  final StorageInfoModel storageInfo;
  final VoidCallback onScanPressed;
  final ValueChanged<int> onNavTap;
  final List<String> categorySizes;

  const DashboardScreen({
    super.key,
    required this.storageInfo,
    required this.onScanPressed,
    required this.onNavTap,
    this.categorySizes = const ['1.2 GB', '340 MB', '186 MB', '4.6 GB'],
  });

  @override
  Widget build(BuildContext context) {
    final usedGb = (storageInfo.usedBytes / (1024 * 1024 * 1024)).toStringAsFixed(1);
    final totalGb = (storageInfo.totalBytes / (1024 * 1024 * 1024)).toStringAsFixed(0);
    final freeGb = (storageInfo.freeBytes / (1024 * 1024 * 1024)).toStringAsFixed(1);
    final pct = (storageInfo.usedPercentage / 100.0).clamp(0.0, 1.0);

    return Canvas360(
      children: [
        tx(24, 82, 'Hi, Fardin', 26, w: FontWeight.w800),
        tx(24, 106, 'Phone health: Good', 14, c: Tk.deep),
        ring(180, 250, 92, pct),
        tx(180, 238, '$usedGb GB', 34, w: FontWeight.w800, a: TextAlign.center),
        tx(180, 258, 'of $totalGb GB used', 13, c: Tk.muted, a: TextAlign.center),
        box(118, 270, 60, 30, r: 11, color: const Color(0xFFD1FAE5)),
        tx(148, 282, 'Used', 9, c: const Color(0xFF065F46), a: TextAlign.center),
        tx(148, 295, '$usedGb GB', 10, w: FontWeight.w700, c: const Color(0xFF065F46), a: TextAlign.center),
        box(182, 270, 60, 30, r: 11, color: Colors.white, border: Border.all(color: Tk.line)),
        tx(212, 282, 'Free', 9, c: Tk.ink2, a: TextAlign.center),
        tx(212, 295, '$freeGb GB', 10, w: FontWeight.w700, c: Tk.ink2, a: TextAlign.center),
        pillBtn(90, 388, 180, 52, 'Scan Junk', icon: 'spark', onTap: onScanPressed),
        ...catGrid(460, categorySizes, onTap: (i) {
            final screens = [
              const AppCacheScreen(),
              const ResidualFilesScreen(),
              const LogsTempScreen(),
              AnalyzerScreen(storageInfo: storageInfo, onNavTap: onNavTap),
            ];
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => screens[i]),
            );
          }),
        tx(24, 642, 'Real device storage · $freeGb GB free', 13, c: Tk.faint),
        Positioned(
          left: 16,
          top: 700,
          width: 328,
          height: 62,
          child: BottomPillNav(active: 0, onTap: onNavTap),
        ),
      ],
    );
  }
}
