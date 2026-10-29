import 'package:flutter/material.dart';

const _ic = <String, String>{
  'home': 'M3 10.5 12 3l9 7.5V20a1 1 0 0 1-1 1h-5v-6H9v6H4a1 1 0 0 1-1-1z',
  'chart': 'M5 20V11M12 20V5M19 20v-6M3 21h18',
  'apps': 'M5 3h3.5a2 2 0 0 1 2 2v3.5a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2zM15.5 3H19a2 2 0 0 1 2 2v3.5a2 2 0 0 1-2 2h-3.5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2zM5 13.5h3.5a2 2 0 0 1 2 2V19a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-3.5a2 2 0 0 1 2-2zM15.5 13.5H19a2 2 0 0 1 2 2V19a2 2 0 0 1 2 2h-3.5a2 2 0 0 1-2-2v-3.5a2 2 0 0 1 2-2z',
  'gear': 'M15.2 12a3.2 3.2 0 1 1-6.4 0 3.2 3.2 0 1 1 6.4 0zM19 12a7 7 0 1 1-14 0 7 7 0 1 1 14 0zM12 2.5v2.5M12 19v2.5M2.5 12H5M19 12h2.5M5.3 5.3l1.8 1.8M16.9 16.9l1.8 1.8M5.3 18.7l1.8-1.8M16.9 7.1l1.8-1.8',
  'cache': 'M12 3 3 7.5l9 4.5 9-4.5zM3 12l9 4.5 9-4.5M3 16.5 12 21l9-4.5',
  'folder': 'M3 6.5A1.5 1.5 0 0 1 4.5 5H9l2 2.5h8.5A1.5 1.5 0 0 1 21 9v9.5a1.5 1.5 0 0 1-1.5 1.5h-15A1.5 1.5 0 0 1 3 18.5zM9.5 14h5',
  'log': 'M6 3h8l4 4v13a1 1 0 0 1-1 1H6a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1zM14 3v4h4M8.5 12h7M8.5 15.5h7M8.5 9h3',
  'dupe': 'M11 8h7a3 3 0 0 1 3 3v7a3 3 0 0 1-3 3h-7a3 3 0 0 1-3-3v-7a3 3 0 0 1 3-3zM16 8V5a2 2 0 0 0-2-2H5a2 2 0 0 0-2 2v9a2 2 0 0 0 2 2h3',
  'back': 'M20 12H4M10 6l-6 6 6 6',
  'check': 'M6 12.5l4 4 8-9',
  'lock': 'M7 11h10a1 1 0 0 1 1 1v7a1 1 0 0 1-1 1H7a1 1 0 0 1-1-1v-7a1 1 0 0 1 1-1zM8.5 11V8a3.5 3.5 0 0 1 7 0v3',
  'globe': 'M21 12a9 9 0 1 1-18 0 9 9 0 1 1 18 0zM12 3c-5 5-5 13 0 18M12 3c5 5 5 13 0 18M3 12h18',
  'send': 'M21 3 3 10.5l7 2.5 2.5 7z',
  'play': 'M8 5v14l11-7z',
  'image': 'M3 19l6-7 4 4 3-3 5 6z',
  'spark': 'M12 2l2.2 7.8L22 12l-7.8 2.2L12 22l-2.2-7.8L2 12l7.8-2.2z',
  'chevron': 'M9 18l6-6-6-6',
};

final _cache = <String, Path>{};
Path _svg(String d) => _cache.putIfAbsent(d, () => _SvgPath(d).parse());

class SvgIcon extends StatelessWidget {
  final String name;
  final double size;
  final Color color;
  final double stroke;
  final bool fill;

  const SvgIcon(
    this.name, {
    super.key,
    this.size = 20,
    this.color = Colors.white,
    this.stroke = 2,
    this.fill = false,
  });

  @override
  Widget build(BuildContext c) => CustomPaint(
        size: Size.square(size),
        painter: _IconP(_svg(_ic[name] ?? 'M0 0'), color, stroke, fill),
      );
}

class _IconP extends CustomPainter {
  final Path p;
  final Color c;
  final double sw;
  final bool fill;

  _IconP(this.p, this.c, this.sw, this.fill);

  @override
  void paint(Canvas canvas, Size s) {
    final k = s.width / 24;
    canvas.scale(k);
    canvas.drawPath(
      p,
      Paint()
        ..color = c
        ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
        ..strokeWidth = sw / k
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(_IconP o) => o.c != c || o.p != p;
}

class _SvgPath {
  final String d;
  int i = 0;

  _SvgPath(this.d);

  final _num = RegExp(r'-?(\d+\.?\d*|\.\d+)(e-?\d+)?');

  double _n() {
    final m = _num.matchAsPrefix(d.substring(i).trimLeft().replaceFirst(RegExp(r'^,'), '').trimLeft())!;
    final skip = d.substring(i).length - d.substring(i).trimLeft().replaceFirst(RegExp(r'^,'), '').trimLeft().length;
    i += skip + m.end;
    return double.parse(m.group(0)!);
  }

  bool _hasNum() {
    final r = d.substring(i).trimLeft().replaceFirst(RegExp(r'^,'), '').trimLeft();
    return r.isNotEmpty && RegExp(r'[-\d.]').hasMatch(r[0]);
  }

  double _flag() {
    final r = d.substring(i);
    final t = r.trimLeft().replaceFirst(RegExp(r'^,'), '').trimLeft();
    i += r.length - t.length + 1;
    return t[0] == '1' ? 1 : 0;
  }

  Path parse() {
    final p = Path();
    double x = 0, y = 0, sx = 0, sy = 0;
    String cmd = 'M';
    while (true) {
      final rest = d.substring(i).trimLeft();
      if (rest.isEmpty) break;
      i = d.length - rest.length;
      if (RegExp(r'[A-Za-z]').hasMatch(rest[0])) {
        cmd = rest[0];
        i++;
      }
      final rel = cmd == cmd.toLowerCase();
      final ox = rel ? x : 0.0, oy = rel ? y : 0.0;
      switch (cmd.toUpperCase()) {
        case 'M':
          x = ox + _n();
          y = oy + _n();
          p.moveTo(x, y);
          sx = x;
          sy = y;
          cmd = rel ? 'l' : 'L';
          break;
        case 'L':
          x = ox + _n();
          y = oy + _n();
          p.lineTo(x, y);
          break;
        case 'H':
          x = ox + _n();
          p.lineTo(x, y);
          break;
        case 'V':
          y = (rel ? y : 0) + _n();
          p.lineTo(x, y);
          break;
        case 'C':
          final a = ox + _n(), b = oy + _n(), c2 = ox + _n(), e = oy + _n();
          x = ox + _n();
          y = oy + _n();
          p.cubicTo(a, b, c2, e, x, y);
          break;
        case 'A':
          final rx = _n(), ry = _n(), rot = _n(), la = _flag(), sw = _flag();
          x = ox + _n();
          y = oy + _n();
          p.arcToPoint(
            Offset(x, y),
            radius: Radius.elliptical(rx, ry),
            rotation: rot,
            largeArc: la == 1,
            clockwise: sw == 1,
          );
          break;
        case 'Z':
          p.close();
          x = sx;
          y = sy;
          break;
      }
      if (cmd.toUpperCase() == 'Z' && _hasNum()) cmd = 'L';
    }
    return p;
  }
}
