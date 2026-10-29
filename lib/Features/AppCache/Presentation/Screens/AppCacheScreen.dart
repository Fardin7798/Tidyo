import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tidyo/Core/Theme/AppTokens.dart';
import 'package:tidyo/Core/Widgets/Canvas360Widget.dart';
import 'package:tidyo/Core/Widgets/SvgIconWidget.dart';

class AppCacheItem {
  final String name, package, letter;
  final double mb;
  final List<Color> g;
  const AppCacheItem(this.name, this.package, this.letter, this.mb, this.g);
}

class AppCacheScreen extends StatefulWidget {
  final List<AppCacheItem> apps;
  final void Function(String package)? onOpenAppInfo;

  const AppCacheScreen({
    super.key,
    this.apps = defaultApps,
    this.onOpenAppInfo,
  });

  static const defaultApps = [
    AppCacheItem('YouTube', 'com.google.android.youtube', 'Y', 412, [
      Color(0xFFF87171),
      Color(0xFFDC2626),
    ]),
    AppCacheItem('Instagram', 'com.instagram.android', 'I', 286, [
      Color(0xFFF472B6),
      Color(0xFFA855F7),
    ]),
    AppCacheItem('Chrome', 'com.android.chrome', 'C', 198, [
      Color(0xFFFACC15),
      Color(0xFF22C55E),
    ]),
    AppCacheItem('Spotify', 'com.spotify.music', 'S', 154, [
      Color(0xFF4ADE80),
      Color(0xFF15803D),
    ]),
    AppCacheItem('Google Maps', 'com.google.android.apps.maps', 'M', 96, [
      Color(0xFF60A5FA),
      Color(0xFF2563EB),
    ]),
  ];

  @override
  State<AppCacheScreen> createState() => _AppCacheState();
}

class _AppCacheState extends State<AppCacheScreen> {
  static const _channel = MethodChannel('com.tidyo.tidyo/app_settings');
  bool bySize = true;
  late final Set<String> sel = widget.apps.take(3).map((a) => a.package).toSet();

  Future<void> _openAppSettings(String packageName) async {
    if (widget.onOpenAppInfo != null) {
      widget.onOpenAppInfo!(packageName);
      return;
    }
    try {
      await _channel.invokeMethod('openAppInfo', {'package': packageName});
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Opening App Info for $packageName'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _handleClearCache(double selMb) {
    if (sel.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one app to clear cache'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    final firstPkg = sel.first;
    final appName = widget.apps.firstWhere((a) => a.package == firstPkg).name;
    _openAppSettings(firstPkg);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening $appName Settings -> Tap "Storage & cache" -> "Clear cache"'),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext c) {
    final list = [...widget.apps]
      ..sort((a, b) => bySize ? b.mb.compareTo(a.mb) : a.name.compareTo(b.name));
    final maxMb = widget.apps.map((a) => a.mb).reduce(math.max);
    final totalMb = widget.apps.fold<double>(0, (t, a) => t + a.mb);
    final selMb = widget.apps
        .where((a) => sel.contains(a.package))
        .fold<double>(0, (t, a) => t + a.mb);

    return Canvas360(
      waveH: 200,
      children: [
        ...detailHeader(c, 'App Cache'),
        ...summaryCard(
          'Cache in ${widget.apps.length} apps',
          fmtMb(totalMb),
          math.min(1.0, totalMb / 2048.0),
        ),
        chipW(24, 192, 72, 'Size', bySize, () => setState(() => bySize = true)),
        chipW(104, 192, 72, 'Name', !bySize, () => setState(() => bySize = false)),
        linkText(
          336,
          213,
          'Select all',
          () => setState(() => sel.addAll(widget.apps.map((a) => a.package))),
        ),
        card(16, 238, 328, list.length * 72.0 + 8, r: 26),
        for (var i = 0; i < list.length; i++) ...() {
          final a = list[i], y = 242.0 + i * 72;
          return [
            box(
              32,
              y + 14,
              44,
              44,
              r: 14,
              grad: LinearGradient(
                colors: a.g,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            tx(
              54,
              y + 42,
              a.letter,
              18,
              w: FontWeight.w800,
              c: Colors.white,
              a: TextAlign.center,
            ),
            tx(90, y + 30, a.name, 14, w: FontWeight.w600),
            tx(90, y + 46, a.package, 11, c: Tk.faint),
            tx(
              296,
              y + 30,
              fmtMb(a.mb),
              13,
              w: FontWeight.w700,
              a: TextAlign.right,
            ),
            box(90, y + 54, 206, 5, r: 2.5, color: Tk.line),
            box(
              90,
              y + 54,
              206 * a.mb / maxMb,
              5,
              r: 2.5,
              grad: Tk.primary,
            ),
            Positioned(
              left: 16,
              top: y,
              width: 280,
              height: 72,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _openAppSettings(a.package),
              ),
            ),
            checkBox(
              320,
              y + 36,
              sel.contains(a.package),
              () => setState(() => sel.contains(a.package)
                  ? sel.remove(a.package)
                  : sel.add(a.package)),
            ),
            if (i < list.length - 1)
              box(90, y + 71, 238, 1, r: 0, color: Tk.line),
          ];
        }(),
        box(
          16,
          622,
          328,
          64,
          r: 20,
          color: const Color(0xFFECFDF5),
          border: Border.all(color: Tk.waveA),
        ),
        Positioned(
          left: 31,
          top: 645,
          child: const SvgIcon('lock', size: 18, color: Color(0xFF0F766E)),
        ),
        tx(
          60,
          648,
          'Android 11+ clears each app’s cache',
          12,
          w: FontWeight.w600,
          c: Tk.deep,
        ),
        tx(
          60,
          666,
          'via its system App Info page',
          12,
          c: const Color(0xFF0F766E),
        ),
        pillBtn(
          16,
          704,
          328,
          56,
          'Clear Cache · ${fmtMb(selMb)}',
          onTap: () => _handleClearCache(selMb),
        ),
      ],
    );
  }
}
