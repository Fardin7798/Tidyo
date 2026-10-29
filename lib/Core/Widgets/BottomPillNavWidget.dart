import 'package:flutter/material.dart';
import '../Theme/AppTokens.dart';
import 'SvgIconWidget.dart';

class BottomPillNav extends StatelessWidget {
  final int active;
  final ValueChanged<int>? onTap;

  const BottomPillNav({super.key, required this.active, this.onTap});

  static const _items = [
    ('Home', 'home'),
    ('Analyzer', 'chart'),
    ('Apps', 'apps'),
    ('Settings', 'gear'),
  ];

  @override
  Widget build(BuildContext c) => Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(31),
          border: Border.all(color: Colors.white, width: 1.5),
          boxShadow: Tk.shadow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var i = 0; i < 4; i++)
              GestureDetector(
                onTap: () => onTap?.call(i),
                child: Container(
                  width: 72,
                  height: 48,
                  decoration: i == active
                      ? BoxDecoration(
                          gradient: Tk.primary,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: Tk.glow,
                        )
                      : null,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgIcon(
                        _items[i].$2,
                        size: 18,
                        color: i == active ? Colors.white : Tk.muted,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _items[i].$1,
                        style: TextStyle(
                          fontFamily: Tk.font,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: i == active ? Colors.white : Tk.muted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      );
}

Widget nav(int active, {ValueChanged<int>? onTap}) => Positioned(
      left: 16,
      top: 700,
      width: 328,
      height: 62,
      child: BottomPillNav(active: active, onTap: onTap),
    );
