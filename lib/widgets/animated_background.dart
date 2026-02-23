import 'package:flutter/material.dart';
import 'dart:math' as math;

class PositionedBackground extends StatelessWidget {
  final AnimatedBackground background;
  
  const PositionedBackground({
    Key? key,
    required this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: background,
    );
  }
}

class AnimatedBackground extends StatefulWidget {
  final Color backgroundColor;
  final bool isDark;
  
  const AnimatedBackground({
    Key? key,
    required this.backgroundColor,
    this.isDark = true,
  }) : super(key: key);

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: widget.isDark
              ? CloudyBackgroundPainter(_controller.value)
              : LightBackgroundPainter(_controller.value),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: widget.isDark
                    ? [
                        widget.backgroundColor,
                        widget.backgroundColor.withOpacity(0.8),
                      ]
                    : [
                        widget.backgroundColor,
                        widget.backgroundColor.withOpacity(0.95),
                      ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Dark background painter - stars only
class CloudyBackgroundPainter extends CustomPainter {
  final double animation;

  CloudyBackgroundPainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Twinkling stars
    for (int i = 0; i < 100; i++) {
      final x = (size.width * ((i * 0.13 + animation * 0.1) % 1.0));
      final y = size.height * ((i * 0.17) % 1.0);
      final twinkle = (math.sin(animation * math.pi * 2 + i) + 1) / 2;

      final starSize = i % 3 == 0 ? 2.5 : (i % 2 == 0 ? 1.5 : 1.0);

      canvas.drawCircle(
        Offset(x, y),
        starSize + twinkle * 1.5,
        paint..color = Colors.white.withOpacity(0.3 + twinkle * 0.7),
      );
    }
  }

  @override
  bool shouldRepaint(CloudyBackgroundPainter oldDelegate) => true;
}

// Light elegant background painter
class LightBackgroundPainter extends CustomPainter {
  final double animation;

  LightBackgroundPainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw flowing waves
    final path = Path();

    for (int i = 0; i < 3; i++) {
      path.reset();
      final yOffset = size.height * (0.3 + i * 0.2);

      path.moveTo(0, yOffset);

      for (double x = 0; x <= size.width; x += 10) {
        final y = yOffset +
            math.sin((x / size.width * 2 * math.pi) +
                    (animation * 2 * math.pi) +
                    i) *
                30;
        path.lineTo(x, y);
      }

      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();

      paint.color = const Color(0xFF2323AE).withOpacity(0.03 + (i * 0.02));
      canvas.drawPath(path, paint);
    }

    // Floating particles
    paint.color = const Color(0xFF2323AE).withOpacity(0.1);
    for (int i = 0; i < 20; i++) {
      final x = size.width * ((i * 0.15 + animation * 0.5) % 1.0);
      final y = size.height * ((i * 0.23 + animation * 0.3) % 1.0);
      final particleSize = 3 + (i % 3) * 2;

      canvas.drawCircle(Offset(x, y), particleSize.toDouble(), paint);
    }
  }

  @override
  bool shouldRepaint(LightBackgroundPainter oldDelegate) => true;
}