import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tidyo/Core/Theme/AppTokens.dart';
import 'package:tidyo/Core/Widgets/Canvas360Widget.dart';
import 'package:tidyo/Core/Widgets/SvgIconWidget.dart';

class ResidualFolder {
  final String path;
  final double mb;
  final List<(String, String)> subs;
  const ResidualFolder(this.path, this.mb, [this.subs = const []]);
}

class ResidualFilesScreen extends StatefulWidget {
  final List<ResidualFolder> folders;

  const ResidualFilesScreen({
    super.key,
    this.folders = defaultFolders,
  });

  static const defaultFolders = [
    ResidualFolder('/Android/data/com.oldgame.app', 85),
    ResidualFolder(
      '/Android/data/com.photoedit.pro',
      35,
      [('cache', '18 MB'), ('files', '12 MB'), ('obb', '5 MB')],
    ),
    ResidualFolder('/Android/media/com.vpn.free', 14),
    ResidualFolder('/Android/obb/com.shopkart', 12),
  ];

  @override
  State<ResidualFilesScreen> createState() => _ResidualState();
}

class _ResidualState extends State<ResidualFilesScreen> {
  late List<ResidualFolder> currentFolders = [...widget.folders];
  late final Set<int> sel = {0, 1};
  int? open = 1;

  void _deleteSelected(double selMb) {
    if (sel.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No residual folders selected'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final deletedCount = sel.length;
    final freedString = fmtMb(selMb);

    // Perform actual deletion if physical folders exist on external storage
    for (final index in sel) {
      if (index < currentFolders.length) {
        final f = currentFolders[index];
        final fullPath = '/storage/emulated/0${f.path}';
        final dir = Directory(fullPath);
        if (dir.existsSync()) {
          try {
            dir.deleteSync(recursive: true);
          } catch (_) {}
        }
      }
    }

    setState(() {
      currentFolders = [
        for (int i = 0; i < currentFolders.length; i++)
          if (!sel.contains(i)) currentFolders[i],
      ];
      sel.clear();
      open = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Successfully deleted $deletedCount residual folders ($freedString freed)'),
        backgroundColor: Tk.teal,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext c) {
    var y = 218.0;
    final rows = <Widget>[];

    for (var i = 0; i < currentFolders.length; i++) {
      final f = currentFolders[i];
      final ex = open == i && f.subs.isNotEmpty;
      final h = 64.0 + (ex ? f.subs.length * 26 + 12 : 0);
      final yy = y;
      final disp = f.path.length <= 24 ? f.path : '${f.path.substring(0, 23)}…';

      rows.addAll([
        card(16, yy, 328, h, r: 22),
        box(
          30,
          yy + 12,
          40,
          40,
          r: 12,
          grad: const LinearGradient(
            colors: Tk.gResid,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          child: const Center(child: SvgIcon('folder', size: 20)),
        ),
        tx(82, yy + 29, disp, 12, w: FontWeight.w600),
        tx(
          82,
          yy + 46,
          'App uninstalled',
          11,
          w: FontWeight.w600,
          c: const Color(0xFFD97706),
        ),
        tx(296, yy + 38, fmtMb(f.mb), 13, w: FontWeight.w700, a: TextAlign.right),
        Positioned(
          left: 16,
          top: yy,
          width: 280,
          height: 64,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => setState(() => open = open == i ? null : i),
          ),
        ),
        checkBox(
          320,
          yy + 33,
          sel.contains(i),
          () => setState(() => sel.contains(i) ? sel.remove(i) : sel.add(i)),
        ),
        if (ex)
          box(
            49.25,
            yy + 60,
            1.5,
            f.subs.length * 26.0 - 6,
            r: 0,
            color: const Color(0xFFCBD5E1),
          ),
        if (ex)
          for (var j = 0; j < f.subs.length; j++) ...[
            box(
              50,
              yy + 72 + j * 26 - .75,
              12,
              1.5,
              r: 0,
              color: const Color(0xFFCBD5E1),
            ),
            at(
              74,
              yy + 72 + j * 26,
              14,
              const SvgIcon('folder', size: 14, color: Tk.faint, stroke: 1.8),
            ),
            tx(88, yy + 76 + j * 26, f.subs[j].$1, 12, c: Tk.ink2),
            tx(
              296,
              yy + 76 + j * 26,
              f.subs[j].$2,
              12,
              w: FontWeight.w600,
              c: Tk.faint,
              a: TextAlign.right,
            ),
          ],
      ]);
      y += h + 10;
    }

    final totalMb = currentFolders.fold<double>(0, (t, f) => t + f.mb);
    final selMb = sel.fold<double>(
      0,
      (t, i) => i < currentFolders.length ? t + currentFolders[i].mb : t,
    );

    return Canvas360(
      waveH: 200,
      children: [
        ...detailHeader(c, 'Residual Files'),
        ...summaryCard(
          'From 9 uninstalled apps',
          fmtMb(totalMb),
          0.55,
        ),
        tx(24, 206, 'Orphan folders', 15, w: FontWeight.w700),
        linkText(
          336,
          206,
          'Select all',
          () => setState(
            () => sel.addAll(List.generate(currentFolders.length, (i) => i)),
          ),
        ),
        ...rows,
        tx(
          180,
          y + 20,
          currentFolders.isEmpty
              ? 'All residual files clean!'
              : '+ 5 more folders',
          12,
          w: FontWeight.w600,
          c: const Color(0xFF0F766E),
          a: TextAlign.center,
        ),
        pillBtn(
          16,
          704,
          328,
          56,
          'Delete Selected · ${fmtMb(selMb)}',
          onTap: () => _deleteSelected(selMb),
        ),
      ],
    );
  }
}
