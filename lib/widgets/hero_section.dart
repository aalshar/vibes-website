import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../constants/colors.dart';
import '../utils/responsive.dart';
import '../widgets/animated_background.dart';
import '../widgets/animated_logo.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    
return Container(
  width: double.infinity,
  height: Responsive.height(context),
  child: Stack(
children: [
  // Animated dark cloudy background
  Positioned.fill(
    child: const AnimatedBackground(
      backgroundColor: AppColors.black,
      isDark: true,
    ),
  ),
          
          // Subtle bottom light effect
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.bottomCenter,
                  radius: 0.8,
                  colors: [
                    Colors.white.withOpacity(0.4),
                    Colors.white.withOpacity(0.2),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
          
          // Brand logo at top left
Positioned(
  top: isMobile ? 20 : 30,
  left: isMobile ? 20 : 30,
  child: Image.asset(
    'assets/Logo-10.png',
    height: isMobile ? 40 : 60,
    fit: BoxFit.contain,
  ),
),
          
          // Content
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 80,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated tagline
                  SizedBox(
                    height: isMobile ? 60 : 80,
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Discover Amazing Restaurants',
                          textStyle: TextStyle(
                            fontSize: isMobile ? 20 : 32,
                            color: AppColors.cream,
                            fontWeight: FontWeight.w300,
                          ),
                          speed: const Duration(milliseconds: 100),
                        ),
                        TypewriterAnimatedText(
                          'Explore Saudi Arabia\'s Cuisine',
                          textStyle: TextStyle(
                            fontSize: isMobile ? 20 : 32,
                            color: AppColors.cream,
                            fontWeight: FontWeight.w300,
                          ),
                          speed: const Duration(milliseconds: 100),
                        ),
                        TypewriterAnimatedText(
                          'Connect with People',
                          textStyle: TextStyle(
                            fontSize: isMobile ? 20 : 32,
                            color: AppColors.cream,
                            fontWeight: FontWeight.w300,
                          ),
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  
                  // Download buttons
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildDownloadButton(
                        icon: Icons.apple,
                        label: 'App Store',
                        onPressed: () {},
                      ),
                      _buildDownloadButton(
                        icon: Icons.android,
                        label: 'Google Play',
                        onPressed: () {},
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 60),
                  
                  // Scroll indicator
                  Column(
                    children: [
                      Text(
                        'Scroll to explore',
                        style: TextStyle(
                          color: AppColors.cream.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.cream.withOpacity(0.7),
                        size: 32,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
        if (!isMobile)
          Positioned(
            top: 150,
            right: 50,
            child: _buildFloatingText(
              'AI Powered',
              isMobile,
            ),
          ),
          
          if (!isMobile)
          Positioned(
            left: 30,
            top: MediaQuery.of(context).size.height * 0.4,
            child: RotatedBox(
              quarterTurns: 3,
              child: _buildFloatingText(
                'Smart Filters',
                isMobile,
              ),
            ),
          ),
          
          if (!isMobile)
          Positioned(
            right: 30,
            top: MediaQuery.of(context).size.height * 0.5,
            child: RotatedBox(
              quarterTurns: 1,
              child: _buildFloatingText(
                'Top Rankings',
                isMobile,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 24),
      label: Text(
        label,
        style: const TextStyle(fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: const Color(0xFFF6EFE6),
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 8,
      ),
    );
  }
  
  Widget _buildFloatingText(String text, bool isMobile) {
    return AnimatedTextKit(
      repeatForever: true,
      pause: const Duration(milliseconds: 2000),
      animatedTexts: [
        TypewriterAnimatedText(
          text,
          textStyle: TextStyle(
            fontSize: isMobile ? 14 : 18,
            color: AppColors.cream.withOpacity(0.6),
            fontWeight: FontWeight.w400,
          ),
          speed: const Duration(milliseconds: 100),
        ),
      ],
    );
  }
}