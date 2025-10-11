import 'package:flutter/material.dart';
import 'dart:math' as math;

class FlyingIcon extends StatefulWidget {
  final double scrollProgress; // 0.0 to 1.0
  final Size screenSize;
  
  const FlyingIcon({
    Key? key,
    required this.scrollProgress,
    required this.screenSize,
  }) : super(key: key);

  @override
  State<FlyingIcon> createState() => _FlyingIconState();
}

class _FlyingIconState extends State<FlyingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

@override
Widget build(BuildContext context) {
  // Calculate position based on scroll
  final progress = widget.scrollProgress.clamp(0.0, 1.0);
  
  final isMobile = widget.screenSize.width < 650;
  
  final startX = widget.screenSize.width / 2 - 60;
  final startY = isMobile 
    ? widget.screenSize.height * 0.12  // Moved up from 0.15 to 0.12
    : widget.screenSize.height * 0.20;

  // End position: top-right
  final endX = isMobile 
    ? widget.screenSize.width - 80
    : widget.screenSize.width - 150;
  final endY = isMobile ? 120.0 : 100.0;
  
  // Smooth curve animation
  final curvedProgress = Curves.easeInOutCubic.transform(progress);
  
  final currentX = startX + (endX - startX) * curvedProgress;
  final currentY = startY + (endY - startY) * curvedProgress;
  
  // Size changes: starts at 120, grows to 180, then shrinks to 100
  double size;
  if (progress < 0.5) {
    size = 120 + (60 * (progress / 0.5));
  } else {
    size = 180 - (80 * ((progress - 0.5) / 0.5));
  }
  
  return AnimatedBuilder(
    animation: _floatController,
    builder: (context, child) {
      final float = math.sin(_floatController.value * math.pi * 2) * 10;
      
      return Positioned(
        left: currentX,
        top: currentY + float,
        child: Container(
          width: size,
          height: size,
          child: ClipOval(
            child: Image.asset(
              'assets/ICON-10.png',
              fit: BoxFit.cover,
              color: null,
              colorBlendMode: BlendMode.dst,
            ),
          ),
        ),
      );
    },
  );
}
}