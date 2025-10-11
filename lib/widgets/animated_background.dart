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

// Dark cloudy background painter with realistic clouds
class CloudyBackgroundPainter extends CustomPainter {
  final double animation;

  CloudyBackgroundPainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30); // Softer edges

    // Background layer - very subtle large clouds
    for (int i = 0; i < 6; i++) {
      final offset = (animation * 0.3 + i * 0.2) % 1.0;
      final x = size.width * offset - 100;
      final y = size.height * (0.1 + i * 0.15);
      
      paint.color = Colors.white.withOpacity(0.03);
      
      // Large fluffy cloud formation
      _drawCloud(canvas, paint, Offset(x, y), 200, 150);
    }

    // Middle layer - medium clouds
    for (int i = 0; i < 10; i++) {
      final offset = (animation * 0.5 + i * 0.12) % 1.0;
      final x = size.width * offset - 50;
      final y = size.height * (0.15 + i * 0.08);
      
      paint.color = Colors.white.withOpacity(0.08 + (i * 0.01));
      
      // Medium fluffy clouds
      _drawCloud(canvas, paint, Offset(x, y), 150, 100);
    }

    // Front layer - smaller, more visible clouds
    for (int i = 0; i < 15; i++) {
      final offset = (animation * 0.8 + i * 0.08) % 1.0;
      final x = size.width * offset;
      final y = size.height * (0.1 + i * 0.06);
      
      paint.color = Colors.white.withOpacity(0.15 + (i * 0.008));
      
      // Smaller detailed clouds
      _drawCloud(canvas, paint, Offset(x, y), 100, 70);
    }

    // Wispy clouds (stretched horizontal clouds)
    paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 50);
    for (int i = 0; i < 8; i++) {
      final offset = (animation * 0.4 + i * 0.15) % 1.0;
      final x = size.width * offset - 150;
      final y = size.height * (0.2 + i * 0.1);
      
      paint.color = Colors.white.withOpacity(0.05);
      
      // Stretched wispy clouds
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(x, y),
          width: 400,
          height: 60,
        ),
        paint,
      );
    }

    // Add twinkling stars
    paint.maskFilter = null;
    for (int i = 0; i < 100; i++) {
      final x = (size.width * ((i * 0.13 + animation * 0.1) % 1.0));
      final y = size.height * ((i * 0.17) % 1.0);
      final twinkle = (math.sin(animation * math.pi * 2 + i) + 1) / 2;
      
      // Different star sizes
      final starSize = i % 3 == 0 ? 2.5 : (i % 2 == 0 ? 1.5 : 1.0);
      
      canvas.drawCircle(
        Offset(x, y),
        starSize + twinkle * 1.5,
        paint..color = Colors.white.withOpacity(0.3 + twinkle * 0.7),
      );
    }

    // Add subtle moon glow
    final moonX = size.width * 0.85;
    final moonY = size.height * 0.15;
    
    paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 40);
    paint.color = Colors.white.withOpacity(0.05);
    canvas.drawCircle(Offset(moonX, moonY), 100, paint);
    
    paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);
    paint.color = Colors.white.withOpacity(0.08);
    canvas.drawCircle(Offset(moonX, moonY), 60, paint);
    
    paint.maskFilter = null;
    paint.color = Colors.white.withOpacity(0.15);
    canvas.drawCircle(Offset(moonX, moonY), 30, paint);
  }

  // Helper method to draw realistic fluffy clouds
  void _drawCloud(Canvas canvas, Paint paint, Offset center, double width, double height) {
    // Main cloud body (multiple overlapping circles)
    canvas.drawCircle(center, height * 0.6, paint);
    canvas.drawCircle(Offset(center.dx - width * 0.2, center.dy), height * 0.5, paint);
    canvas.drawCircle(Offset(center.dx + width * 0.2, center.dy), height * 0.5, paint);
    canvas.drawCircle(Offset(center.dx - width * 0.1, center.dy - height * 0.3), height * 0.45, paint);
    canvas.drawCircle(Offset(center.dx + width * 0.1, center.dy - height * 0.2), height * 0.4, paint);
    
    // Add puffs for fluffiness
    canvas.drawCircle(Offset(center.dx - width * 0.3, center.dy + height * 0.1), height * 0.35, paint);
    canvas.drawCircle(Offset(center.dx + width * 0.3, center.dy + height * 0.1), height * 0.35, paint);
  }

  @override
  bool shouldRepaint(CloudyBackgroundPainter oldDelegate) => true;
}
// Light elegant background painter
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
            math.sin((x / size.width * 2 * math.pi) + (animation * 2 * math.pi) + i) * 30;
        path.lineTo(x, y);
      }
      
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();
      
      paint.color = const Color(0xFF2323AE).withOpacity(0.03 + (i * 0.02));
      canvas.drawPath(path, paint);
    }

    // Add floating particles
    paint.color = const Color(0xFF2323AE).withOpacity(0.1);
    for (int i = 0; i < 20; i++) {
      final x = size.width * ((i * 0.15 + animation * 0.5) % 1.0);
      final y = size.height * ((i * 0.23 + animation * 0.3) % 1.0);
      final particleSize = 3 + (i % 3) * 2; // Changed variable name from 'size' to 'particleSize'
      
      canvas.drawCircle(Offset(x, y), particleSize.toDouble(), paint);
    }
  }

  @override
  bool shouldRepaint(LightBackgroundPainter oldDelegate) => true;
}