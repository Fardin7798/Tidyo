import 'dart:math' as math;
import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../Core/Theme/AppTokens.dart';
import '../../../../Core/Widgets/Canvas360Widget.dart';

class LogFile {
  final String name, dir, size, date;
  final double mb;
  final List<String> previewLines;

  const LogFile(
    this.name,
    this.dir,
    this.size,
    this.date,
    this.mb, {
    this.previewLines = const [],
  });
}

class LogsTempScreen extends StatefulWidget {
  const LogsTempScreen({super.key});

  static const defaultFiles = [
    LogFile(
      'system.log',
      '/data/local/logs',
      '2.3 MB',
      'Oct 26',
      2.3,
      previewLines: [
        '10-26 14:22:01.104 I/ActivityManager: START u0',
        '10-26 14:22:01.218 D/BatteryService: level: 84%, temp: 298',
        '10-26 14:22:02.044 W/PackageManager: package stale cache',
        '10-26 14:22:03.119 I/WindowState: updateFocusedWindow: true',
        '10-26 14:22:04.551 D/AudioFlinger: mixer thread sleep',
        '10-26 14:22:05.002 I/ThermalEngine: CPU temp normal (34C)',
      ],
    ),
    LogFile(
      'app_crash.crashlog',
      '/Android/media/.crash',
      '840 KB',
      'Oct 25',
      0.82,
      previewLines: [
        'FATAL EXCEPTION: main',
        'Process: com.demo.app, PID: 4120',
        'java.lang.NullPointerException: Null object ref',
        'at com.demo.MainActivity.onCreate(MainActivity.kt:42)',
        'at android.app.Activity.performCreate(Activity.java:8290)',
        'at android.app.ActivityThread.main(ActivityThread.java:8080)',
      ],
    ),
    LogFile(
      'browser.tmp',
      '/Download/.tmp',
      '5.1 MB',
      'Oct 24',
      5.1,
      previewLines: [
        'CHUNK 0x00000000 - 0x00000FFF [GZIP DATA]',
        'Content-Type: application/octet-stream',
        'Transfer-Encoding: chunked (partial dl: 72%)',
        'ETag: "63f8a0-2819-5d3c8"',
        'Cache-Control: public, max-age=86400',
        'CRC32 checksum valid [0x9B42A1F8]',
      ],
    ),
    LogFile(
      'upload_82.tmp',
      '/Pictures/.temp',
      '1.6 MB',
      'Oct 22',
      1.6,
      previewLines: [
        'MEDIA_UPLOAD_SESSION #82',
        'Target: /storage/emulated/0/DCIM/Camera',
        'Buffer: 16777216 bytes allocated',
        'Transferred: 1677721 / 16777216 (10%)',
        'Network: Wi-Fi (WPA3-SAE, 5GHz, RSSI: -48dBm)',
        'State: PAUSED (Waiting for reconnection)',
      ],
    ),
    LogFile(
      'debug_trace.log',
      '/Documents/logs',
      '920 KB',
      'Oct 20',
      0.90,
      previewLines: [
        'TRACE BEGIN: session_id=0x7FA29',
        '2026-10-20 09:12:30.012 - GC_FOR_ALLOC freed 12MB',
        '2026-10-20 09:12:31.442 - RenderThread: 5 dropped frames',
        '2026-10-20 09:12:33.001 - SQLiteQuery: SELECT * FROM cache',
        '2026-10-20 09:12:34.120 - SocketChannel: connect ok',
        '2026-10-20 09:12:35.890 - TRACE END: duration 5878ms',
      ],
    ),
  ];

  @override
  State<LogsTempScreen> createState() => _LogsState();
}

class _LogsState extends State<LogsTempScreen> {
  int filter = 1;
  late List<LogFile> files = [...LogsTempScreen.defaultFiles];
  final sel = <int>{0, 1};
  int previewIdx = 1;

  List<LogFile> get filteredFiles {
    if (filter == 0) {
      return files.where((f) => f.name.endsWith('.log')).toList();
    } else if (filter == 1) {
      return files.where((f) => f.name.endsWith('.crashlog')).toList();
    } else {
      return files.where((f) => f.name.endsWith('.tmp')).toList();
    }
  }

  void _deleteSelected(double selMb) {
    if (sel.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No files selected for deletion'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final deletedCount = sel.length;
    final freedString = fmtMb(selMb);

    // Physically attempt to delete file if it exists
    for (final index in sel) {
      if (index < files.length) {
        final f = files[index];
        final fullPath = '/storage/emulated/0${f.dir}/${f.name}';
        final file = File(fullPath);
        if (file.existsSync()) {
          try {
            file.deleteSync();
          } catch (_) {}
        }
      }
    }

    setState(() {
      files = [
        for (int i = 0; i < files.length; i++)
          if (!sel.contains(i)) files[i],
      ];
      sel.clear();
      previewIdx = 0;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleted $deletedCount log & temp files ($freedString freed)'),
        backgroundColor: Tk.teal,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  List<Widget> _row(double y, int i, bool last) {
    final f = files[i];
    return [
      gIcon(50, y + 28, Tk.gLogs, 'log', r: 18),
      tx(78, y + 24, f.name, 13, w: FontWeight.w600),
      tx(78, y + 40, f.dir, 11, c: Tk.faint),
      tx(296, y + 24, f.size, 12, w: FontWeight.w700, a: TextAlign.right),
      tx(296, y + 40, f.date, 11, c: Tk.faint, a: TextAlign.right),
      Positioned(
        left: 16,
        top: y,
        width: 280,
        height: 56,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => setState(() => previewIdx = i),
        ),
      ),
      checkBox(
        320,
        y + 28,
        sel.contains(i),
        () => setState(() => sel.contains(i) ? sel.remove(i) : sel.add(i)),
      ),
      if (!last) box(78, y + 55, 250, 1, r: 0, color: Tk.line),
    ];
  }

  @override
  Widget build(BuildContext c) {
    final activeFile = files.isNotEmpty
        ? (previewIdx < files.length ? files[previewIdx] : files.first)
        : null;
    final preview = activeFile?.previewLines ?? const [
      'No log content available',
      'Log file deleted or empty',
    ];

    final selMb = sel.fold<double>(
      0,
      (t, i) => i < files.length ? t + files[i].mb : t,
    );

    final logCount = files.where((f) => f.name.endsWith('.log')).length;
    final crashCount = files.where((f) => f.name.endsWith('.crashlog')).length;
    final tmpCount = files.where((f) => f.name.endsWith('.tmp')).length;

    return Canvas360(
      waveH: 180,
      children: [
        ...detailHeader(c, 'Logs & Temp'),
        chipW(
          24,
          92,
          86,
          '.log $logCount',
          filter == 0,
          () => setState(() => filter = 0),
        ),
        chipW(
          118,
          92,
          116,
          '.crashlog $crashCount',
          filter == 1,
          () => setState(() => filter = 1),
        ),
        chipW(
          242,
          92,
          94,
          '.tmp $tmpCount',
          filter == 2,
          () => setState(() => filter = 2),
        ),
        if (files.isNotEmpty) ...[
          card(16, 138, 328, math.min(files.length, 2) * 56.0 + 8),
          for (var i = 0; i < math.min(files.length, 2); i++)
            ..._row(142 + i * 56.0, i, i == math.min(files.length, 2) - 1),
        ],
        card(16, 270, 328, 170),
        tx(34, 298, 'Preview', 13, w: FontWeight.w700),
        if (activeFile != null)
          tx(
            326,
            298,
            activeFile.name,
            11,
            w: FontWeight.w600,
            c: Tk.faint,
            a: TextAlign.right,
          ),
        box(30, 310, 300, 116, r: 14, color: Tk.ink),
        for (var j = 0; j < math.min(preview.length, 6); j++)
          Positioned(
            left: 42,
            top: 332 + j * 17 - 10.5 * .96875,
            width: 276,
            child: Text(
              preview[j],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                height: 1.2109375,
                color: (j == 0 && activeFile != null && activeFile.name.contains('crash'))
                    ? const Color(0xFFF87171)
                    : const Color(0xFFCBD5E1),
              ),
            ),
          ),
        if (files.length > 2) ...[
          card(16, 452, 328, (files.length - 2) * 56.0 + 8),
          for (var i = 0; i < files.length - 2; i++)
            ..._row(456 + i * 56.0, 2 + i, i == files.length - 3),
        ],
        pillBtn(
          16,
          704,
          328,
          56,
          'Delete ${fmtMb(selMb)} Selected',
          onTap: () => _deleteSelected(selMb),
        ),
      ],
    );
  }
}
