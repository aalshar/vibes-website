import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/responsive.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/animated_background.dart';

class ScreenshotsSection extends StatefulWidget {
  const ScreenshotsSection({Key? key}) : super(key: key);

  @override
  State<ScreenshotsSection> createState() => _ScreenshotsSectionState();
}

class _ScreenshotsSectionState extends State<ScreenshotsSection> {
  late PageController _pageController;
  int _currentPage = 4;

  // Screenshot descriptions - index 4 is the default
  final List<String> _screenshotDescriptions = [
    'Find your next favorite spot',
    'Your culinary adventure starts here',
    'Every detail at your fingertips',
    'Welcome to endless possibilities',
    'Beautiful interface, seamless experience', // index 4 - default
    'Chat, explore, discover together',
    'Filter your way to perfection',
    'Ranked by the best, for the best',
    'Build your foodie network',
    'Your vibe, your profile',
  ];

  @override
  void initState() {
    super.initState();
    // Initialize with proper viewport fraction
    _pageController = PageController(
      viewportFraction: 0.45, // Show more side cards
      initialPage: 4,
    );
    
    _pageController.addListener(() {
      if (_pageController.hasClients) {
        int next = _pageController.page!.round();
        if (_currentPage != next) {
          setState(() {
            _currentPage = next;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Container(
      width: double.infinity,
      height: screenHeight,
      child: Stack(
        children: [
          // Animated dark cloudy background (same as Hero, About, Features)
          Positioned.fill(
            child: const AnimatedBackground(
              backgroundColor: Colors.black,
              isDark: true,
            ),
          ),
          
          // Content
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: isMobile ? 40 : 50,
                  left: isMobile ? 24 : 80,
                  right: isMobile ? 24 : 80,
                  bottom: isMobile ? 20 : 20,
                ),
                child: Column(
                  children: [
                    Text(
                      'See It In Action',
                      style: TextStyle(
                        fontSize: isMobile ? 28 : 48,
                        fontWeight: FontWeight.bold,
                        color: AppColors.cream,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: isMobile ? 10 : 12),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        _screenshotDescriptions[_currentPage],
                        key: ValueKey<int>(_currentPage),
                        style: GoogleFonts.lilitaOne(
                          fontSize: isMobile ? 15 : 20,
                          fontWeight: FontWeight.w500,
                          color: AppColors.cream.withOpacity(0.7),
                          letterSpacing: 0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Carousel with proper height
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return _buildCarouselItem(
                              index, 
                              isMobile, 
                              constraints.maxHeight,
                            );
                          },
                        ),
                        
                        // Page indicators (dots)
                        Positioned(
                          bottom: isMobile ? 30 : 20,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(10, (index) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                width: _currentPage == index ? 24 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _currentPage == index
                                      ? AppColors.cream
                                      : AppColors.cream.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              
              SizedBox(height: isMobile ? 50 : 50),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselItem(int index, bool isMobile, double maxHeight) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 1.0;
        double opacity = 1.0;
        double rotationY = 0.0;
        
        if (_pageController.position.haveDimensions) {
          value = _pageController.page! - index;
          
          // Calculate distance and effects
          final distance = value.abs();
          if (distance == 0) {
            // Center card
            value = 1.0;
            opacity = 1.0;
            rotationY = 0.0;
          } else if (distance <= 1) {
            // Adjacent cards - more visible on mobile
            value = isMobile 
                ? 1.0 - (distance * 0.20) // Mobile: scale down to 80%
                : 1.0 - (distance * 0.25); // Desktop: scale down to 75%
            opacity = isMobile
                ? 1.0 - (distance * 0.20) // Mobile: less fade
                : 1.0 - (distance * 0.30); // Desktop: more fade
            rotationY = value * 0.3;
          } else {
            // Far cards
            value = isMobile ? 0.75 : 0.7;
            opacity = isMobile ? 0.6 : 0.5;
            rotationY = value * 0.5;
          }
        }
        
        // Better sizes for mobile to match desktop proportions
        final baseHeight = isMobile ? 480.0 : 550.0;
        final baseWidth = isMobile ? 260.0 : 300.0;
        
        final height = baseHeight * value.clamp(0.7, 1.0);
        final width = baseWidth * value.clamp(0.7, 1.0);
        
        // Calculate shadow intensity based on position
        final isCenter = (index == _currentPage);
        
        return Center(
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // perspective
              ..rotateY(rotationY * (value > 0 ? -1 : 1)), // 3D rotation
            alignment: Alignment.center,
            child: Opacity(
              opacity: opacity,
              child: SizedBox(
                height: height,
                width: width,
                child: child,
              ),
            ),
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: isMobile ? 8 : 8,
            vertical: isMobile ? 30 : 30,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isMobile ? 28 : 32),
            boxShadow: [
              // Base shadow - stronger for mobile
              BoxShadow(
                color: AppColors.cream.withOpacity(
                  index == _currentPage 
                      ? (isMobile ? 0.20 : 0.15)
                      : (isMobile ? 0.12 : 0.08)
                ),
                blurRadius: index == _currentPage 
                    ? (isMobile ? 50 : 40)
                    : (isMobile ? 30 : 20),
                spreadRadius: index == _currentPage ? 2 : 0,
                offset: Offset(0, index == _currentPage ? 15 : 10),
              ),
              // Blue glow shadow
              BoxShadow(
                color: AppColors.blue.withOpacity(
                  index == _currentPage 
                      ? (isMobile ? 0.35 : 0.30)
                      : (isMobile ? 0.20 : 0.15)
                ),
                blurRadius: index == _currentPage 
                    ? (isMobile ? 60 : 50)
                    : (isMobile ? 40 : 30),
                spreadRadius: index == _currentPage ? -5 : -10,
                offset: Offset(0, index == _currentPage ? 20 : 15),
              ),
              // Additional glow for center card
              if (index == _currentPage)
                BoxShadow(
                  color: AppColors.cream.withOpacity(isMobile ? 0.15 : 0.10),
                  blurRadius: isMobile ? 70 : 60,
                  spreadRadius: 10,
                  offset: const Offset(0, 25),
                ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(isMobile ? 28 : 32),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.cream.withOpacity(
                    index == _currentPage 
                        ? (isMobile ? 0.35 : 0.30)
                        : (isMobile ? 0.20 : 0.15)
                  ),
                  width: index == _currentPage 
                      ? (isMobile ? 2.5 : 2)
                      : 1,
                ),
                borderRadius: BorderRadius.circular(isMobile ? 28 : 32),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(isMobile ? 26 : 30),
                child: Image.asset(
                  'assets/screenshot_${index + 1}.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}