import 'package:flutter/material.dart';
import 'package:tidyo/Core/Theme/AppTokens.dart';
import 'package:tidyo/Core/Widgets/Canvas360Widget.dart';
import 'package:tidyo/Core/Widgets/SvgIconWidget.dart';
import 'package:tidyo/Core/Models/JunkItemModel.dart';

enum Tier { on, off, lock }

class ResultsScreen extends StatefulWidget {
  final List<JunkItemModel> items;
  final VoidCallback onBack;
  final Future<void> Function(List<JunkItemModel> selectedItems) onCleanPressed;

  const ResultsScreen({
    super.key,
    required this.items,
    required this.onBack,
    required this.onCleanPressed,
  });

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  late List<JunkItemModel> _currentItems;
  bool _isCleaning = false;

  @override
  void initState() {
    super.initState();
    _currentItems = List.from(widget.items);
  }

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

  List<Widget> _section(
    double y,
    String tag,
    Color col,
    Color bg,
    List<JunkItemModel> sectionItems,
    Tier tierType,
    void Function(double) next,
  ) {
    final h = (sectionItems.isEmpty ? 1 : sectionItems.length) * 40.0 + 8;
    final dim = tierType == Tier.lock;
    next(y + 30 + h + 12);

    return [
      box(20, y, tag.length * 7.0 + 30, 24, r: 12, color: bg),
      dot(32, y + 12, 4, fill: col),
      tx(42, y + 16, tag, 11, w: FontWeight.w700, c: col),
      card(16, y + 30, 328, h, r: 22, op: dim ? .55 : .9),
      for (var i = 0; i < sectionItems.length; i++) ...() {
        final item = sectionItems[i];
        final yy = y + 34 + i * 40;
        final isChecked = item.isSelected;

        return [
          if (tierType == Tier.on && isChecked)
            dot(40, yy + 20, 10, fill: Tk.green, icon: 'check')
          else if (tierType == Tier.lock)
            at(40, yy + 19, 18, const SvgIcon('lock', size: 18, color: Tk.grey))
          else
            dot(40, yy + 20, 9, stroke: isChecked ? Tk.green : Tk.grey, fill: isChecked ? Tk.green : null, icon: isChecked ? 'check' : null),
          tx(60, yy + 25, item.name, 13, c: dim ? Tk.grey : Tk.ink),
          tx(328, yy + 25, item.formattedSize, 13, w: FontWeight.w700, c: dim ? Tk.grey : Tk.ink, a: TextAlign.right),
          if (i < sectionItems.length - 1)
            box(60, yy + 39, 268, 1, r: 0, color: Tk.line),
          Positioned(
            left: 16,
            top: yy,
            width: 328,
            height: 40,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: tierType == Tier.lock
                  ? null
                  : () {
                      setState(() {
                        item.isSelected = !item.isSelected;
                      });
                    },
              child: const SizedBox.expand(),
            ),
          ),
        ];
      }(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final safeItems = _currentItems.where((i) => i.tier == JunkTier.safe).toList();
    final reviewItems = _currentItems.where((i) => i.tier == JunkTier.review).toList();
    final lockedItems = _currentItems.where((i) => i.tier == JunkTier.locked).toList();

    int totalBytes = 0;
    int selectedBytes = 0;
    for (final item in _currentItems) {
      totalBytes += item.sizeBytes;
      if (item.isSelected && item.tier != JunkTier.locked) {
        selectedBytes += item.sizeBytes;
      }
    }

    var y = 192.0;
    final s1 = _section(
      y,
      '100% Safe',
      const Color(0xFF16A34A),
      const Color(0xFFDCFCE7),
      safeItems,
      Tier.on,
      (n) => y = n,
    );
    final s2 = _section(
      y,
      'Review Required',
      const Color(0xFFD97706),
      const Color(0xFFFEF3C7),
      reviewItems,
      Tier.off,
      (n) => y = n,
    );
    final s3 = _section(
      y,
      'Protected',
      const Color(0xFFDC2626),
      const Color(0xFFFEE2E2),
      lockedItems,
      Tier.lock,
      (n) => y = n,
    );

    return Canvas360(
      waveH: 200,
      children: [
        ...backBar('Scan Results', onBack: widget.onBack),
        card(16, 92, 328, 84, r: 26),
        tx(36, 126, 'Junk found', 13, c: Tk.ink2),
        tx(36, 160, _formatBytes(totalBytes), 30, w: FontWeight.w800),
        at(300, 134, 70, CustomPaint(painter: MiniRingP())),
        ...s1,
        ...s2,
        ...s3,
        pillBtn(
          16,
          704,
          328,
          56,
          _isCleaning ? 'Cleaning...' : 'Clean ${_formatBytes(selectedBytes)} Now',
          onTap: _isCleaning || selectedBytes == 0
              ? null
              : () async {
                  setState(() => _isCleaning = true);
                  final toClean = _currentItems.where((i) => i.isSelected && i.tier != JunkTier.locked).toList();
                  await widget.onCleanPressed(toClean);
                  if (mounted) {
                    setState(() {
                      _currentItems.removeWhere((i) => toClean.contains(i));
                      _isCleaning = false;
                    });
                  }
                },
        ),
      ],
    );
  }
}
