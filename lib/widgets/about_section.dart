import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/responsive.dart';
import '../widgets/animated_background.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    
    return Container(
      width: double.infinity,
      height: Responsive.height(context), // Fixed height
      child: Stack(
        children: [
          // Animated light background
          const AnimatedBackground(
            backgroundColor: Colors.black,
            isDark: false,
          ),
          
          // Content - Made scrollable
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 80,
                  vertical: 80, // Reduced from 100
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Column(
                    children: [
                      // Section title
                      Text(
                        'About Vibes',
                        style: TextStyle(
                          fontSize: isMobile ? 32 : 48, // Reduced sizes
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFF6EFE6),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16), // Reduced spacing
                      
                      // Subtitle
                      Text(
                        'Your Gateway to Saudi Arabia\'s Culinary Scene',
                        style: TextStyle(
                          fontSize: isMobile ? 14 : 20, // Reduced sizes
                          color: const Color(0xFFF6EFE6).withOpacity(0.8),
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40), // Reduced spacing
                      
                      // Description cards
                      Wrap(
                        spacing: 20, // Reduced spacing
                        runSpacing: 20, // Reduced spacing
                        alignment: WrapAlignment.center,
                        children: [
                          _buildInfoCard(
                            icon: Icons.explore,
                            title: 'Discover',
                            description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                            isMobile: isMobile,
                          ),
                          _buildInfoCard(
                            icon: Icons.filter_list,
                            title: 'Filter',
                            description: 'Ut enim ad minim veniam, quis nostrud exercitation.',
                            isMobile: isMobile,
                          ),
                          _buildInfoCard(
                            icon: Icons.star,
                            title: 'Experience',
                            description: 'Duis aute irure dolor in reprehenderit in voluptate.',
                            isMobile: isMobile,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String description,
    required bool isMobile,
  }) {
    return Container(
      width: isMobile ? double.infinity : 320, // Reduced from 350
      padding: const EdgeInsets.all(24), // Reduced from 32
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFF6EFE6).withOpacity(0.3),
          width:  0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16), // Reduced from 20
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFF6EFE6).withOpacity(0.2),
            ),
            child: Icon(
              icon,
              size: 32, // Reduced from 40
              color: const Color(0xFFF6EFE6),
            ),
          ),
          const SizedBox(height: 16), // Reduced from 24
          Text(
            title,
            style: const TextStyle(
              fontSize: 20, // Reduced from 24
              fontWeight: FontWeight.bold,
              color: Color(0xFFF6EFE6),
            ),
          ),
          const SizedBox(height: 12), // Reduced from 16
          Text(
            description,
            style: TextStyle(
              fontSize: 13, // Reduced from 14
              color: const Color(0xFFF6EFE6).withOpacity(0.8),
              height: 1.5, // Reduced from 1.6
            ),
            textAlign: TextAlign.center,
            maxLines: 3, // Limit lines
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}