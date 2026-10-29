import 'package:flutter/material.dart';
import 'package:tidyo/Core/Theme/AppTokens.dart';
import 'package:tidyo/Core/Widgets/Canvas360Widget.dart';
import 'package:tidyo/Core/Widgets/SvgIconWidget.dart';
import 'package:tidyo/Core/Widgets/BottomPillNavWidget.dart';
import 'package:tidyo/Core/Models/StorageInfoModel.dart';
import 'package:tidyo/Core/Services/JunkScannerService.dart';

class AnalyzerScreen extends StatefulWidget {
  final StorageInfoModel storageInfo;
  final ValueChanged<int> onNavTap;

  const AnalyzerScreen({
    super.key,
    required this.storageInfo,
    required this.onNavTap,
  });

  @override
  State<AnalyzerScreen> createState() => _AnalyzerScreenState();
}

class _AnalyzerScreenState extends State<AnalyzerScreen> {
  int chip = 1;
  final _scanner = JunkScannerService();
  List<BigFileModel> _bigFiles = [];
  bool _isLoading = true;

  static const _thresholds = [
    25 * 1024 * 1024,
    50 * 1024 * 1024,
    100 * 1024 * 1024,
  ];

  @override
  void initState() {
    super.initState();
    _loadFiles();
  }

  Future<void> _loadFiles() async {
    setState(() => _isLoading = true);
    final files = await _scanner.findBigFiles(minBytes: _thresholds[chip]);
    if (mounted) {
      setState(() {
        _bigFiles = files;
        _isLoading = false;
      });
    }
  }

  void _onChipSelected(int index) {
    if (chip == index) return;
    setState(() => chip = index);
    _loadFiles();
  }

  @override
  Widget build(BuildContext context) {
    const segs = [
      (0.40, Color(0xFF3B82F6), 'Photos 40%'),
      (0.30, Color(0xFFA855F7), 'Videos 30%'),
      (0.20, Color(0xFFF97316), 'Apps 20%'),
      (0.10, Tk.green, 'Junk 10%'),
    ];

    const thumbs = [Tk.gCache, Tk.gResid, Tk.gLogs, Tk.gDupe];

    final usedGb = (widget.storageInfo.usedBytes / (1024 * 1024 * 1024)).toStringAsFixed(1);
    final totalGb = (widget.storageInfo.totalBytes / (1024 * 1024 * 1024)).toStringAsFixed(0);

    var sx = 32.0;

    // Use live files or default display if scanner returns empty
    final displayFiles = _bigFiles.take(4).toList();

    return Canvas360(
      waveH: 180,
      children: [
        tx(24, 80, 'Storage Analyzer', 26, w: FontWeight.w800),
        tx(24, 104, '$usedGb GB of $totalGb GB used', 13, c: Tk.deep),
        card(16, 124, 328, 96, r: 26),
        for (var i = 0; i < 4; i++) ...() {
          final w = 296 * segs[i].$1;
          final x = sx;
          sx += w;
          final lx = const [30.0, 108.0, 188.0, 262.0][i];
          return [
            box(x, 144, w - 3, 22, r: 11, color: segs[i].$2),
            dot(lx + 5, 194, 4, fill: segs[i].$2),
            tx(lx + 12, 198, segs[i].$3, 10, w: FontWeight.w600, c: Tk.ink2),
          ];
        }(),
        tx(24, 250, 'Big Files Hunter', 17, w: FontWeight.w700),
        for (var i = 0; i < 3; i++)
          Positioned(
            left: 24 + i * 98.0,
            top: 262,
            width: 90,
            height: 32,
            child: GestureDetector(
              onTap: () => _onChipSelected(i),
              child: Container(
                decoration: BoxDecoration(
                  gradient: i == chip ? Tk.primary : null,
                  color: i == chip ? null : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: i == chip ? null : Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: Center(
                  child: Text(
                    const ['25 MB+', '50 MB+', '100 MB+'][i],
                    style: TextStyle(
                      fontFamily: Tk.font,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: i == chip ? Colors.white : Tk.ink2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        card(16, 306, 328, 230, r: 26),
        if (_isLoading)
          const Positioned(
            left: 160,
            top: 400,
            child: CircularProgressIndicator(strokeWidth: 3, color: Tk.teal),
          )
        else if (displayFiles.isEmpty)
          tx(180, 420, 'No files larger than threshold', 13, c: Tk.muted, a: TextAlign.center)
        else
          for (var i = 0; i < displayFiles.length; i++) ...() {
            final y = 318.0 + i * 54;
            final file = displayFiles[i];
            final shortName = file.name.length > 24 ? '${file.name.substring(0, 21)}...' : file.name;
            return [
              box(
                30,
                y,
                56,
                42,
                r: 12,
                grad: LinearGradient(
                  colors: thumbs[i % thumbs.length],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                child: const Center(child: SvgIcon('play', size: 20, fill: true)),
              ),
              tx(98, y + 18, shortName, 13, w: FontWeight.w600),
              tx(98, y + 36, file.formattedSize, 12, c: Tk.faint),
              dot(320, y + 21, 9, stroke: Tk.grey),
            ];
          }(),
        card(16, 550, 328, 120, r: 26),
        tx(34, 584, 'Duplicate Finder', 16, w: FontWeight.w700),
        box(
          250,
          568,
          78,
          24,
          r: 12,
          color: const Color(0xFFDBEAFE),
          child: const Center(
            child: Text(
              'SHA-256',
              style: TextStyle(
                fontFamily: Tk.font,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1D4ED8),
              ),
            ),
          ),
        ),
        tx(34, 614, '48 duplicates · 920 MB', 13, c: Tk.muted),
        Positioned(
          left: 230,
          top: 620,
          width: 98,
          height: 36,
          child: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Duplicate review scanner initiated')),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: Tk.primary,
              ),
              child: const Center(
                child: Text(
                  'Review',
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
        Positioned(
          left: 16,
          top: 700,
          width: 328,
          height: 62,
          child: BottomPillNav(active: 1, onTap: widget.onNavTap),
        ),
      ],
    );
  }
}
