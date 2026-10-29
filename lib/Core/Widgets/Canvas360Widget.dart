import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../Theme/AppTokens.dart';
import 'SvgIconWidget.dart';

Widget tx(
  double x,
  double y,
  String s,
  double size, {
  FontWeight w = FontWeight.w500,
  Color c = Tk.ink,
  TextAlign a = TextAlign.left,
}) {
  final top = y - size * 0.96875;
  final t = Text(
    s,
    maxLines: 1,
    softWrap: false,
    textAlign: a,
    style: TextStyle(
      fontFamily: Tk.font,
      fontSize: size,
      fontWeight: w,
      color: c,
      height: 1.2109375,
      leadingDistribution: TextLeadingDistribution.proportional,
    ),
  );
  if (a == TextAlign.center) {
    return Positioned(left: x - 160, width: 320, top: top, child: t);
  }
  if (a == TextAlign.right) {
    return Positioned(right: 360 - x, top: top, child: t);
  }
  return Positioned(left: x, top: top, child: t);
}

Widget box(
  double x,
  double y,
  double w,
  double h, {
  double r = 24,
  Color? color,
  Gradient? grad,
  BoxBorder? border,
  List<BoxShadow>? sh,
  Widget? child,
}) =>
    Positioned(
      left: x,
      top: y,
      width: w,
      height: h,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          gradient: grad,
          borderRadius: BorderRadius.circular(r),
          border: border,
          boxShadow: sh,
        ),
        child: child,
      ),
    );

Widget card(
  double x,
  double y,
  double w,
  double h, {
  double r = 24,
  double op = .85,
}) =>
    box(
      x,
      y,
      w,
      h,
      r: r,
      color: Colors.white.withValues(alpha: op),
      border: Border.all(color: Colors.white, width: 1.5),
      sh: Tk.shadow,
    );

Widget at(double cx, double cy, double s, Widget child) =>
    Positioned(left: cx - s / 2, top: cy - s / 2, width: s, height: s, child: child);

Widget gIcon(double cx, double cy, List<Color> g, String icon, {double r = 20}) => at(
      cx,
      cy,
      r * 2,
      Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: g,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(child: SvgIcon(icon, size: 20)),
      ),
    );

Widget dot(
  double cx,
  double cy,
  double r, {
  Color? fill,
  Color? stroke,
  double sw = 2,
  String? icon,
}) =>
    at(
      cx,
      cy,
      r * 2,
      Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: fill,
          border: stroke == null ? null : Border.all(color: stroke, width: sw),
        ),
        child: icon == null
            ? null
            : Center(child: SvgIcon(icon, size: r * 1.3, stroke: 2.4)),
      ),
    );

class Canvas360 extends StatelessWidget {
  final double waveH;
  final bool wave;
  final List<Widget> children;

  const Canvas360({
    super.key,
    this.waveH = 250,
    this.wave = true,
    required this.children,
  });

  @override
  Widget build(BuildContext c) => Scaffold(
        backgroundColor: Tk.bgBottom,
        body: FittedBox(
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 360,
            height: 780,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(child: CustomPaint(painter: _BgP(wave, waveH))),
                ...children,
              ],
            ),
          ),
        ),
      );
}

class _BgP extends CustomPainter {
  final bool wave;
  final double h;

  _BgP(this.wave, this.h);

  @override
  void paint(Canvas c, Size s) {
    final r = Offset.zero & s;
    c.drawRect(
      r,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Tk.bgTop, Tk.bgBottom],
        ).createShader(r),
    );
    if (!wave) return;
    final p = Path()
      ..moveTo(0, 0)
      ..lineTo(360, 0)
      ..lineTo(360, h - 40)
      ..cubicTo(300, h - 110, 230, h - 50, 170, h - 60)
      ..cubicTo(110, h - 70, 50, h - 20, 0, h)
      ..close();
    c.drawPath(
      p,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Tk.waveA, Tk.waveB],
        ).createShader(Rect.fromLTWH(0, 0, 360, h))
        ..color = Colors.white.withValues(alpha: 0.9),
    );
  }

  @override
  bool shouldRepaint(_BgP o) => false;
}

class _RingP extends CustomPainter {
  final double pct, r;

  _RingP(this.pct, this.r);

  @override
  void paint(Canvas c, Size s) {
    final o = s.center(Offset.zero);
    c.drawCircle(
      o,
      r + 26,
      Paint()
        ..color = const Color(0xFF0F766E).withValues(alpha: 0.12)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );
    c.drawCircle(o, r + 26, Paint()..color = Colors.white.withValues(alpha: 0.8));
    c.drawCircle(
      o,
      r + 26,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
    c.drawCircle(
      o,
      r,
      Paint()
        ..color = Tk.line
        ..style = PaintingStyle.stroke
        ..strokeWidth = 16,
    );
    final rect = Rect.fromCircle(center: o, radius: r);
    final arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round
      ..shader = Tk.primary.createShader(rect);
    c.drawArc(
      rect.shift(const Offset(0, 6)),
      -math.pi / 2,
      2 * math.pi * pct,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 16
        ..strokeCap = StrokeCap.round
        ..color = Tk.green.withValues(alpha: 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );
    c.drawArc(rect, -math.pi / 2, 2 * math.pi * pct, false, arc);
  }

  @override
  bool shouldRepaint(_RingP o) => o.pct != pct;
}

Widget ring(double cx, double cy, double r, double pct) =>
    at(cx, cy, (r + 30) * 2, CustomPaint(painter: _RingP(pct, r)));

class MiniRingP extends CustomPainter {
  @override
  void paint(Canvas c, Size s) {
    final r = Rect.fromCircle(center: s.center(Offset.zero), radius: 26);
    c.drawCircle(
      r.center,
      26,
      Paint()
        ..color = Tk.line
        ..style = PaintingStyle.stroke
        ..strokeWidth = 9,
    );
    c.drawArc(
      r,
      -math.pi / 2,
      2 * math.pi * 130 / 163.4,
      false,
      Paint()
        ..shader = Tk.primary.createShader(r)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 9
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_) => false;
}

Widget pillBtn(
  double x,
  double y,
  double w,
  double h,
  String label, {
  double fs = 17,
  String? icon,
  VoidCallback? onTap,
}) =>
    Positioned(
      left: x,
      top: y,
      width: w,
      height: h,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(h / 2),
            gradient: Tk.primary,
            boxShadow: Tk.glow,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                SvgIcon(icon, size: 14, fill: true),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: TextStyle(
                  fontFamily: Tk.font,
                  fontSize: fs,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );

List<Widget> backBar(String title, {VoidCallback? onBack}) => [
      Positioned(
        left: 22,
        top: 50,
        child: GestureDetector(
          onTap: onBack,
          child: const SvgIcon('back', size: 22, color: Tk.ink, stroke: 2.2),
        ),
      ),
      tx(180, 70, title, 18, w: FontWeight.w700, a: TextAlign.center),
    ];

const cats = [
  ('App Cache', Tk.gCache, 'cache'),
  ('Residual Files', Tk.gResid, 'folder'),
  ('Logs & Temp', Tk.gLogs, 'log'),
  ('Large & Dupes', Tk.gDupe, 'dupe'),
];

List<Widget> catGrid(double y, List<String> vals, {List<bool?>? done, void Function(int)? onTap}) => [
      for (var i = 0; i < 4; i++) ...() {
        final x = 16.0 + (i % 2) * 168, yy = y + (i ~/ 2) * 82;
        return [
          card(x, yy, 160, 72, r: 22),
          Positioned(left: x, top: yy, width: 160, height: 72, child: GestureDetector(behavior: HitTestBehavior.opaque, onTap: () => onTap?.call(i))),
          gIcon(x + 32, yy + 36, cats[i].$2, cats[i].$3),
          tx(x + 60, yy + 30, cats[i].$1, 12, c: Tk.ink2),
          tx(x + 60, yy + 52, vals[i], 17, w: FontWeight.w800),
          if (done != null && done[i] == true)
            dot(x + 144, yy + 58, 8, fill: Tk.green, icon: 'check'),
          if (done != null && done[i] == false)
            at(
              x + 144,
              yy + 58,
              16,
              const CircularProgressIndicator(
                strokeWidth: 2.5,
                color: Tk.teal,
                value: .5,
              ),
            ),
        ];
      }(),
    ];

// ───────────── v4 shared bits ─────────────
List<Widget> detailHeader(BuildContext c, String title) => [
  Positioned(
    left: 14,
    top: 40,
    width: 40,
    height: 40,
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(c).maybePop(),
      child: const Center(
        child: SvgIcon('back', size: 22, color: Tk.ink, stroke: 2.2),
      ),
    ),
  ),
  tx(180, 70, title, 18, w: FontWeight.w700, a: TextAlign.center),
];

class MiniRing extends CustomPainter {
  final double f;
  MiniRing(this.f);
  @override
  void paint(Canvas c, Size s) {
    final r = Rect.fromCircle(center: s.center(Offset.zero), radius: 26);
    c.drawCircle(
      r.center,
      26,
      Paint()
        ..color = Tk.line
        ..style = PaintingStyle.stroke
        ..strokeWidth = 9,
    );
    c.drawArc(
      r,
      -math.pi / 2,
      2 * math.pi * f,
      false,
      Paint()
        ..shader = Tk.primary.createShader(r)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 9
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(MiniRing o) => o.f != f;
}

List<Widget> summaryCard(String label, String value, double frac) => [
  card(16, 92, 328, 84, r: 26),
  tx(36, 126, label, 13, c: Tk.ink2),
  tx(36, 160, value, 30, w: FontWeight.w800),
  at(300, 134, 70, CustomPaint(painter: MiniRing(frac))),
];

Widget checkBox(double cx, double cy, bool on, VoidCallback onTap) =>
    Positioned(
      left: cx - 14,
      top: cy - 14,
      width: 28,
      height: 28,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Center(
          child: Container(
            width: on ? 18 : 16,
            height: on ? 18 : 16,
            decoration: BoxDecoration(
              color: on ? Tk.green : Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: on ? null : Border.all(color: Tk.grey, width: 1.8),
            ),
            child: on
                ? const SvgIcon('check', size: 14, stroke: 2.4)
                : null,
          ),
        ),
      ),
    );

Widget chipW(
  double x,
  double y,
  double w,
  String label,
  bool act,
  VoidCallback onTap,
) =>
    Positioned(
      left: x,
      top: y,
      width: w,
      height: 32,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: act ? Tk.primary : null,
            color: act ? null : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: act ? null : Border.all(color: const Color(0xFFCBD5E1)),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: Tk.font,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: act ? Colors.white : Tk.ink2,
              ),
            ),
          ),
        ),
      ),
    );

Widget linkText(double xRight, double y, String s, VoidCallback onTap) =>
    Positioned(
      right: 360 - xRight,
      top: y - 12 * .96875 - 6,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(
            s,
            style: const TextStyle(
              fontFamily: Tk.font,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0F766E),
              height: 1.2109375,
            ),
          ),
        ),
      ),
    );

String fmtMb(double mb) =>
    mb >= 1000 ? '${(mb / 1024).toStringAsFixed(1)} GB' : '${mb.round()} MB';
