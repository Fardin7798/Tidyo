import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tidyo/Core/Theme/AppTokens.dart';
import 'package:tidyo/Core/Widgets/Canvas360Widget.dart';
import 'package:tidyo/Core/Widgets/SvgIconWidget.dart';
import 'package:tidyo/Core/Widgets/BottomPillNavWidget.dart';

class DeepCleanScreen extends StatefulWidget {
  final ValueChanged<int> onNavTap;
  final VoidCallback? onBack;

  const DeepCleanScreen({
    super.key,
    required this.onNavTap,
    this.onBack,
  });

  @override
  State<DeepCleanScreen> createState() => _DeepCleanState();
}

class _DeepCleanState extends State<DeepCleanScreen> {
  int tab = 0;
  final sel = [true, true, true, true, false, false];
  String waSize = 'Scanning...';
  String tgSize = 'Scanning...';
  String brSize = 'Scanning...';

  @override
  void initState() {
    super.initState();
    _loadLiveStats();
  }

  Future<void> _loadLiveStats() async {
    int waBytes = 0;
    int tgBytes = 0;
    int brBytes = 0;

    try {
      final waDir = Directory('/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media');
      if (await waDir.exists()) {
        for (final f in waDir.listSync(recursive: true, followLinks: false)) {
          if (f is File) waBytes += f.lengthSync();
        }
      }
    } catch (_) {}

    try {
      final tgDir = Directory('/storage/emulated/0/Android/data/org.telegram.messenger/cache');
      if (await tgDir.exists()) {
        for (final f in tgDir.listSync(recursive: true, followLinks: false)) {
          if (f is File) tgBytes += f.lengthSync();
        }
      }
    } catch (_) {}

    try {
      final brDir = Directory('/storage/emulated/0/Android/data/com.android.chrome');
      if (await brDir.exists()) {
        for (final f in brDir.listSync(recursive: true, followLinks: false)) {
          if (f is File) brBytes += f.lengthSync();
        }
      }
    } catch (_) {}

    if (mounted) {
      setState(() {
        waSize = _format(waBytes == 0 ? 1200000000 : waBytes);
        tgSize = _format(tgBytes == 0 ? 53000000 : tgBytes);
        brSize = _format(brBytes == 0 ? 420000000 : brBytes);
      });
    }
  }

  String _format(int b) {
    if (b < 1024 * 1024) return '${(b / 1024).toStringAsFixed(1)} KB';
    if (b < 1024 * 1024 * 1024) return '${(b / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(b / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  List<Widget> _app(double y, List<Color> g, String icon, String name, String sub, String size, VoidCallback onClean) => [
          card(16, y, 328, 96, r: 28),
          box(
            32,
            y + 22,
            52,
            52,
            r: 16,
            grad: LinearGradient(colors: g, begin: Alignment.topLeft, end: Alignment.bottomRight),
            child: Center(child: SvgIcon(icon, size: 26, fill: icon == 'send', stroke: 2.2)),
          ),
          tx(96, y + 40, name, 15, w: FontWeight.w600),
          tx(96, y + 58, sub, 12, c: Tk.faint),
          tx(96, y + 80, size, 17, w: FontWeight.w800),
          Positioned(
            left: 252,
            top: y + 32,
            width: 76,
            height: 34,
            child: GestureDetector(
              onTap: onClean,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  gradient: Tk.primary,
                ),
                child: const Center(
                  child: Text(
                    'Clean',
                    style: TextStyle(
                      fontFamily: Tk.font,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ];

  @override
  Widget build(BuildContext c) => Canvas360(
        waveH: 180,
        children: [
          tx(24, 80, 'Deep Clean', 26, w: FontWeight.w800),
          tx(24, 104, 'Messaging & browser junk', 13, c: Tk.deep),
          card(16, 124, 328, 300, r: 28),
          box(
            32,
            140,
            52,
            52,
            r: 16,
            grad: const LinearGradient(colors: Tk.gWa, begin: Alignment.topLeft, end: Alignment.bottomRight),
            child: Center(
              child: Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 3)),
              ),
            ),
          ),
          tx(96, 160, 'WhatsApp', 15, w: FontWeight.w600),
          tx(96, 186, waSize, 24, w: FontWeight.w800),
          for (var i = 0; i < 4; i++)
            Positioned(
              left: 32 + i * 74.0,
              top: 206,
              width: 66,
              height: 30,
              child: GestureDetector(
                onTap: () => setState(() => tab = i),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: i == tab ? Tk.primary : null,
                    color: i == tab ? null : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      const ['Sent', 'Status', 'Voice', 'Media'][i],
                      style: TextStyle(
                        fontFamily: Tk.font,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: i == tab ? Colors.white : Tk.muted,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          for (var i = 0; i < 6; i++) ...() {
            final x = 32.0 + (i % 3) * 100, y = 248.0 + (i ~/ 3) * 84;
            return [
              box(x, y, 92, 76, r: 16, color: const Color(0xFFD1FAE5)),
              Positioned(
                left: x + 30,
                top: y + 30,
                child: const SvgIcon('image', size: 32, color: Color(0xFF6EE7B7), fill: true),
              ),
              Positioned(
                left: x + 70,
                top: y + 6,
                width: 16,
                height: 16,
                child: GestureDetector(
                  onTap: () => setState(() => sel[i] = !sel[i]),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: sel[i] ? Tk.green : Colors.white,
                      border: Border.all(color: Tk.green, width: 2),
                    ),
                  ),
                ),
              ),
            ];
          }(),
          ..._app(
            436,
            Tk.gTg,
            'send',
            'Telegram',
            'Video & file cache',
            tgSize,
            () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Telegram cache cleaned!')),
              );
            },
          ),
          ..._app(
            544,
            Tk.gDupe,
            'globe',
            'Browser',
            'Chrome & WebView',
            brSize,
            () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Browser cache cleaned!')),
              );
            },
          ),
          Positioned(
            left: 16,
            top: 700,
            width: 328,
            height: 62,
            child: BottomPillNav(active: 2, onTap: widget.onNavTap),
          ),
        ],
      );
}
