import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/responsive.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class ScreenshotsSection extends StatefulWidget {
  const ScreenshotsSection({Key? key}) : super(key: key);

  @override
  State<ScreenshotsSection> createState() => _ScreenshotsSectionState();
}

class _ScreenshotsSectionState extends State<ScreenshotsSection> {
  int _currentPage = 0;
  late List<AnimationController> _flipControllers;
  late List<Animation<double>> _flipAnimations;

  final List<String> _screenshotDescriptions = [
    'Explore categories across restaurants, cafés, cinemas/Movies, and leisure venues',
    'Navigate the map to discover nearby venues with ease',
    'Follow friends\' timelines — their likes, reviews, Vibes Ins, and ratings',
    'Ask Vibes AI to find your perfect spot — it understands your taste',
    'Browse the Top 10 venues per category for a quick way to great spots',
    'Chat with friends, share venues, and decide where to go together',
    'Plan full itineraries, share them, and organize every detail of your trip',
    'Build saved lists and Top 10 lists to showcase your favorite taste',
    'Use powerful filters across dozens of options to find exactly what you want',
    'Dive into venue details — images, reviews, menus, offers, and much more',
  ];

  final List<String> _screenshots = List.generate(
    10,
    (i) => 'assets/screenshot_${i + 1}.png',
  );

  @override
  void initState() {
    super.initState();
    _flipControllers = List.generate(
      _screenshots.length,
      (i) => AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: Navigator.of(context as BuildContext),
      ),
    );
    _flipAnimations = _flipControllers
        .map((c) => Tween<double>(begin: 0, end: math.pi)
            .animate(CurvedAnimation(parent: c, curve: Curves.easeInOutBack)))
        .toList();
  }

  @override
  void dispose() {
    for (final c in _flipControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _goToPage(int index) {
    if (index == _currentPage) return;
    setState(() => _currentPage = index);
  }

  void _prev() {
    if (_currentPage > 0) _goToPage(_currentPage - 1);
  }

  void _next() {
    if (_currentPage < _screenshots.length - 1) _goToPage(_currentPage + 1);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final phoneWidth = isMobile ? 200.0 : 260.0;
    final phoneHeight = phoneWidth * 2.05;
    final sidePhoneWidth = phoneWidth * 0.72;
    final sidePhoneHeight = sidePhoneWidth * 2.05;

    // visible indexes: prev, current, next
    final prevIndex = _currentPage > 0 ? _currentPage - 1 : null;
    final nextIndex = _currentPage < _screenshots.length - 1 ? _currentPage + 1 : null;

    return Container(
      width: double.infinity,
      height: screenHeight,
      color: Colors.transparent,
      child: Column(
        children: [
          // ── Title
          Padding(
            padding: EdgeInsets.only(top: isMobile ? 50 : 60),
            child: Column(
              children: [
                Text(
                  'See It In Action',
                  style: TextStyle(
                    fontSize: isMobile ? 28 : 48,
                    fontWeight: FontWeight.bold,
                    color: AppColors.cream,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 32 : 220),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, anim) => FadeTransition(
                      opacity: anim,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.25),
                          end: Offset.zero,
                        ).animate(anim),
                        child: child,
                      ),
                    ),
                    child: Text(
                      _screenshotDescriptions[_currentPage],
                      key: ValueKey<int>(_currentPage),
                      style: GoogleFonts.lilitaOne(
                        fontSize: isMobile ? 13 : 17,
                        color: AppColors.cream.withOpacity(0.6),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // ── Three-phone display
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Left arrow
                Positioned(
                  left: isMobile ? 8 : 40,
                  child: _ArrowButton(
                    icon: Icons.chevron_left_rounded,
                    onTap: _prev,
                    enabled: _currentPage > 0,
                  ),
                ),

                // Right arrow
                Positioned(
                  right: isMobile ? 8 : 40,
                  child: _ArrowButton(
                    icon: Icons.chevron_right_rounded,
                    onTap: _next,
                    enabled: _currentPage < _screenshots.length - 1,
                  ),
                ),

                // Phone trio
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Left phone
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 400),
                      opacity: prevIndex != null ? 1.0 : 0.0,
                      child: GestureDetector(
                        onTap: _prev,
                        child: _SidePhone(
                          imagePath: prevIndex != null
                              ? _screenshots[prevIndex]
                              : _screenshots[0],
                          width: sidePhoneWidth,
                          height: sidePhoneHeight,
                          direction: -1,
                        ),
                      ),
                    ),

                    SizedBox(width: isMobile ? 12 : 24),

                    // Center phone with flip animation
                    _FlipPhone(
                      key: ValueKey<int>(_currentPage),
                      imagePath: _screenshots[_currentPage],
                      width: phoneWidth,
                      height: phoneHeight,
                    ),

                    SizedBox(width: isMobile ? 12 : 24),

                    // Right phone
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 400),
                      opacity: nextIndex != null ? 1.0 : 0.0,
                      child: GestureDetector(
                        onTap: _next,
                        child: _SidePhone(
                          imagePath: nextIndex != null
                              ? _screenshots[nextIndex]
                              : _screenshots[_screenshots.length - 1],
                          width: sidePhoneWidth,
                          height: sidePhoneHeight,
                          direction: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ── Dot indicators
          Padding(
            padding: const EdgeInsets.only(bottom: 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_screenshots.length, (index) {
                return GestureDetector(
                  onTap: () => _goToPage(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 28 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? AppColors.cream
                          : AppColors.cream.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Flip phone: flips in when it becomes the center card
class _FlipPhone extends StatefulWidget {
  final String imagePath;
  final double width;
  final double height;

  const _FlipPhone({
    Key? key,
    required this.imagePath,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  State<_FlipPhone> createState() => _FlipPhoneState();
}

class _FlipPhoneState extends State<_FlipPhone>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _anim = Tween<double>(begin: -math.pi / 2, end: 0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack),
    );
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(_anim.value),
          alignment: Alignment.center,
          child: child,
        );
      },
      child: _PhoneFrame(
        imagePath: widget.imagePath,
        width: widget.width,
        height: widget.height,
        isCenter: true,
      ),
    );
  }
}

// ── Side phone: tilted inward, dark overlay, black border
class _SidePhone extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final int direction; // -1 left, 1 right

  const _SidePhone({
    required this.imagePath,
    required this.width,
    required this.height,
    required this.direction,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(direction * 0.38), // tilt inward toward center
      alignment: direction == -1 ? Alignment.centerRight : Alignment.centerLeft,
      child: _PhoneFrame(
        imagePath: imagePath,
        width: width,
        height: height,
        isCenter: false,
      ),
    );
  }
}

// ── Shared phone frame widget
class _PhoneFrame extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final bool isCenter;

  const _PhoneFrame({
    required this.imagePath,
    required this.width,
    required this.height,
    required this.isCenter,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = width * 0.12;
    final bezelWidth = width * 0.03;
    final notchWidth = width * 0.28;
    final notchHeight = width * 0.052;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.black,
        // Center: white-tinted border. Sides: pure black (invisible)
        border: Border.all(
          color: isCenter
              ? Colors.white.withOpacity(0.28)
              : Colors.black,
          width: bezelWidth,
        ),
        boxShadow: isCenter
            ? [
                BoxShadow(
                  color: Colors.white.withOpacity(0.10),
                  blurRadius: 40,
                  spreadRadius: 4,
                ),
                BoxShadow(
                  color: const Color(0xFF3B82F6).withOpacity(0.22),
                  blurRadius: 60,
                  spreadRadius: -6,
                  offset: const Offset(0, 20),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.9),
                  blurRadius: 12,
                  spreadRadius: 6,
                ),
              ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius - bezelWidth),
        child: Stack(
          children: [
            // Black base
            Container(color: Colors.black),

            // Screenshot
            Positioned.fill(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFF111111),
                  child: Center(
                    child: Icon(
                      Icons.smartphone_outlined,
                      color: Colors.white.withOpacity(0.06),
                      size: width * 0.28,
                    ),
                  ),
                ),
              ),
            ),

            // Dynamic Island
            Positioned(
              top: height * 0.016,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: notchWidth,
                  height: notchHeight,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(notchHeight / 2),
                  ),
                ),
              ),
            ),

            // Dark overlay on side cards
            if (!isCenter)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.55),
                ),
              ),

            // Glare on center only
            if (isCenter)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: height * 0.38,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.07),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ── Arrow button widget
class _ArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool enabled;

  const _ArrowButton({
    required this.icon,
    required this.onTap,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: enabled ? 1.0 : 0.2,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.08),
            border: Border.all(
              color: Colors.white.withOpacity(0.15),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: Colors.white.withOpacity(0.8),
            size: 28,
          ),
        ),
      ),
    );
  }
}