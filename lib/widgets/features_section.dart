import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../constants/colors.dart';
import '../utils/responsive.dart';
import '../widgets/animated_background.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: screenHeight),
      child: Stack(
        children: [
          // Animated dark cloudy background (same as Hero and About)
          Positioned.fill(
            child: const AnimatedBackground(
              backgroundColor: Colors.black,
              isDark: true,
            ),
          ),
          
          // Subtle gradient overlay for depth
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.3),
                  ],
                ),
              ),
            ),
          ),
          
          // Content
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : (isTablet ? 40 : 80),
                vertical: isMobile ? 50 : 80,
              ),
              child: Column(
                children: [
                  // Header
                  Text(
                    'Powerful Features',
                    style: TextStyle(
                      fontSize: isMobile ? 32 : 48,
                      fontWeight: FontWeight.bold,
                      color: AppColors.cream,
                      letterSpacing: -0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isMobile ? 12 : 16),
                  Text(
                    'Everything you need to find your perfect dining experience',
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 18,
                      color: AppColors.cream.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isMobile ? 40 : 60),
              
                  // Features Grid
                  LayoutBuilder(
                    builder: (context, constraints) {
                      // Determine number of columns
                      int crossAxisCount;
                      double childAspectRatio;
                      
                      if (isMobile) {
                        crossAxisCount = 2; // 2 columns on mobile
                        childAspectRatio = 0.85;
                      } else if (isTablet) {
                        crossAxisCount = 3;
                        childAspectRatio = 0.9;
                      } else {
                        crossAxisCount = 3;
                        childAspectRatio = 1.0;
                      }
                      
                      return GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: isMobile ? 12 : 24,
                        mainAxisSpacing: isMobile ? 12 : 24,
                        childAspectRatio: childAspectRatio,
                        children: [
                          _buildFeatureCard(
                            context: context,
                            icon: Icons.smart_toy,
                            title: 'Vibes AI',
                            description: 'Chat with our AI assistant to discover restaurants tailored to your preferences.',
                            accentColor: AppColors.blue,
                            number: '01',
                            isMobile: isMobile,
                          ),
                          _buildFeatureCard(
                            context: context,
                            icon: Icons.emoji_events,
                            title: 'Vibes Best',
                            description: 'Explore top 10 rankings based on authentic ratings and reviews.',
                            accentColor: Color(0xFF9333EA),
                            number: '02',
                            isMobile: isMobile,
                          ),
                          _buildFeatureCard(
                            context: context,
                            icon: Icons.tune,
                            title: 'Smart Filters',
                            description: 'Filter by cuisine, location, features, and price range.',
                            accentColor: Color(0xFF10B981),
                            number: '03',
                            isMobile: isMobile,
                          ),
                          _buildFeatureCard(
                            context: context,
                            icon: Icons.people,
                            title: 'Social Features',
                            description: 'Connect with friends and share recommendations.',
                            accentColor: Color(0xFFEC4899),
                            number: '04',
                            isMobile: isMobile,
                          ),
                          _buildFeatureCard(
                            context: context,
                            icon: Icons.star_rate,
                            title: 'Real Reviews',
                            description: 'Read genuine reviews from real diners.',
                            accentColor: Color(0xFFF59E0B),
                            number: '05',
                            isMobile: isMobile,
                          ),
                          _buildFeatureCard(
                            context: context,
                            icon: Icons.location_on,
                            title: 'Location Based',
                            description: 'Find restaurants near you across Saudi Arabia.',
                            accentColor: Color(0xFF06B6D4),
                            number: '06',
                            isMobile: isMobile,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required Color accentColor,
    required String number,
    required bool isMobile,
  }) {
    return _Floating3DCard(
      icon: icon,
      title: title,
      description: description,
      accentColor: accentColor,
      number: number,
      isMobile: isMobile,
    );
  }
}

class _Floating3DCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color accentColor;
  final String number;
  final bool isMobile;

  const _Floating3DCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.accentColor,
    required this.number,
    required this.isMobile,
  });

  @override
  State<_Floating3DCard> createState() => _Floating3DCardState();
}

class _Floating3DCardState extends State<_Floating3DCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Offset _mousePosition = Offset.zero;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateMousePosition(PointerEvent details, BoxConstraints constraints) {
    setState(() {
      _mousePosition = Offset(
        (details.localPosition.dx - constraints.maxWidth / 2) / constraints.maxWidth,
        (details.localPosition.dy - constraints.maxHeight / 2) / constraints.maxHeight,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) {
            setState(() {
              _isHovered = false;
              _mousePosition = Offset.zero;
            });
          },
          onHover: (event) => _updateMousePosition(event, constraints),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              // Floating animation
              final floatOffset = math.sin(_controller.value * 2 * math.pi) * 10;
              
              // 3D rotation based on mouse position
              final rotateX = _isHovered ? _mousePosition.dy * 0.2 : 0.0;
              final rotateY = _isHovered ? _mousePosition.dx * 0.2 : 0.0;
              
              return TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 200),
                tween: Tween(begin: 0, end: _isHovered ? 1.0 : 0.0),
                builder: (context, hoverValue, child) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001) // perspective
                      ..rotateX(rotateX)
                      ..rotateY(rotateY)
                      ..translate(0.0, floatOffset, 0.0),
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(widget.isMobile ? 20 : 24),
                        boxShadow: [
                          BoxShadow(
                            color: widget.accentColor.withOpacity(0.3 * hoverValue),
                            blurRadius: 40,
                            spreadRadius: -5,
                            offset: Offset(0, 20),
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(widget.isMobile ? 20 : 24),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(widget.isMobile ? 20 : 24),
                            border: Border.all(
                              color: widget.accentColor.withOpacity(0.3 + (0.4 * hoverValue)),
                              width: 1.5,
                            ),
                          ),
                          child: Stack(
                            children: [
                              // Animated gradient overlay on hover
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 300),
                                opacity: hoverValue * 0.1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        widget.accentColor.withOpacity(0.2),
                                        widget.accentColor.withOpacity(0.05),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              
                              // Animated shine effect
                              AnimatedPositioned(
                                duration: const Duration(milliseconds: 300),
                                left: _isHovered ? _mousePosition.dx * 100 : -200,
                                top: _isHovered ? _mousePosition.dy * 100 : -200,
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      colors: [
                                        widget.accentColor.withOpacity(0.2 * hoverValue),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              
                              // Decorative circle background
                              Positioned(
                                right: -40,
                                top: -40,
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: widget.accentColor.withOpacity(0.05),
                                  ),
                                ),
                              ),
                              
                              // Large number watermark
                              Positioned(
                                right: widget.isMobile ? 10 : 16,
                                bottom: widget.isMobile ? 10 : 16,
                                child: Text(
                                  widget.number,
                                  style: TextStyle(
                                    fontSize: widget.isMobile ? 60 : 80,
                                    fontWeight: FontWeight.bold,
                                    color: widget.accentColor.withOpacity(0.1),
                                    height: 1,
                                  ),
                                ),
                              ),
                              
                              // Content
                              Padding(
                                padding: EdgeInsets.all(widget.isMobile ? 16 : 24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Icon with glow effect
                                    Container(
                                      padding: EdgeInsets.all(widget.isMobile ? 10 : 12),
                                      decoration: BoxDecoration(
                                        color: widget.accentColor.withOpacity(0.1 + (0.1 * hoverValue)),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: widget.accentColor.withOpacity(0.3),
                                          width: 1,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: widget.accentColor.withOpacity(0.3 * hoverValue),
                                            blurRadius: 20,
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        widget.icon,
                                        size: widget.isMobile ? 24 : 32,
                                        color: widget.accentColor,
                                      ),
                                    ),
                                    
                                    SizedBox(height: widget.isMobile ? 12 : 16),
                                    
                                    // Title
                                    Text(
                                      widget.title,
                                      style: TextStyle(
                                        fontSize: widget.isMobile ? 16 : 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.cream,
                                      ),
                                    ),
                                    
                                    SizedBox(height: widget.isMobile ? 6 : 8),
                                    
                                    // Description
                                    Expanded(
                                      child: Text(
                                        widget.description,
                                        style: TextStyle(
                                          fontSize: widget.isMobile ? 11 : 13,
                                          color: AppColors.cream.withOpacity(0.8),
                                          height: 1.4,
                                        ),
                                        maxLines: widget.isMobile ? 3 : 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}