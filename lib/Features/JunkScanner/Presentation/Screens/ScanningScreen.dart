import 'package:flutter/material.dart';
import '../../../../Core/Theme/AppTokens.dart';
import '../../../../Core/Widgets/Canvas360Widget.dart';
import '../../../../Core/Widgets/SvgIconWidget.dart';

class ScanningScreen extends StatelessWidget {
  final double progress;
  final int files;
  final String path;
  final int junkBytes;
  final List<String> catValues;
  final List<bool?> catDone;
  final VoidCallback onStop;
  final VoidCallback onBack;

  const ScanningScreen({
    super.key,
    required this.progress,
    required this.files,
    required this.path,
    required this.junkBytes,
    required this.onStop,
    required this.onBack,
    this.catValues = const ['+240 MB', '+86 MB', '+512 MB', '+1.1 GB'],
    this.catDone = const [true, true, true, false],
  });

  String _formatBytes(int bytes) {
    if (bytes <= 0) return '0 B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }

  @override
  Widget build(BuildContext context) {
    final clampedPct = progress.clamp(0.0, 1.0);
    final filesFormatted = files.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+$)'),
      (_) => ',',
    );
    final formattedJunk = _formatBytes(junkBytes);

    // Truncate path if long
    final displayPath = path.length > 36 ? '...${path.substring(path.length - 33)}' : path;

    return Canvas360(
      children: [
        ...backBar('Scanning Junk', onBack: onBack),
        ring(180, 215, 88, clampedPct),
        tx(180, 221, '${(clampedPct * 100).round()}%', 34, w: FontWeight.w800, a: TextAlign.center),
        tx(180, 245, '$filesFormatted files scanned', 13, c: Tk.muted, a: TextAlign.center),
        card(16, 345, 328, 44, r: 22),
        box(
          28,
          355,
          24,
          24,
          r: 8,
          color: const Color(0xFFD1FAE5),
          child: const Center(child: SvgIcon('folder', size: 15, color: Color(0xFF16A34A))),
        ),
        tx(62, 372, displayPath, 11, c: Tk.ink2),
        card(16, 402, 328, 86),
        tx(180, 432, 'Junk found', 14, w: FontWeight.w600, c: Tk.ink2, a: TextAlign.center),
        tx(180, 472, formattedJunk, 34, w: FontWeight.w800, c: const Color(0xFF16A34A), a: TextAlign.center),
        ...catGrid(502, catValues, done: catDone),
        Positioned(
          left: 40,
          top: 690,
          width: 280,
          height: 52,
          child: GestureDetector(
            onTap: onStop,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(26),
                border: Border.all(color: Tk.teal, width: 2),
              ),
              child: const Center(
                child: Text(
                  'Stop Scan',
                  style: TextStyle(
                    fontFamily: Tk.font,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F766E),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
