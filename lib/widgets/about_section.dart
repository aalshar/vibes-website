import 'package:flutter/material.dart';
// ignore: unused_import
import '../constants/colors.dart';
import '../utils/responsive.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Container(
      width: double.infinity,
      height: screenHeight,
      color: Colors.transparent,
      child: Center(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 80,
              vertical: isMobile ? 40 : 80,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Section title
                  Text(
                    'About Vibes',
                    style: TextStyle(
                      fontSize: isMobile ? 28 : 48,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFF6EFE6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isMobile ? 12 : 16),
                  
                  // Subtitle
                  Text(
                    'Your Gateway to Saudi Arabia\'s Culinary Scene',
                    style: TextStyle(
                      fontSize: isMobile ? 13 : 20,
                      color: const Color(0xFFF6EFE6).withOpacity(0.8),
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isMobile ? 30 : 40),
                  
                  // Description cards
                  Wrap(
                    spacing: isMobile ? 12 : 20,
                    runSpacing: isMobile ? 12 : 20,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildInfoCard(
                        icon: Icons.explore,
                        title: 'Discover',
                        description: 'Explore restaurants, cafés, cinemas, and leisure spots across Saudi Arabia. From hidden gems to top-rated venues — find your next favorite place with ease.',
                        isMobile: isMobile,
                        context: context,
                      ),
                      _buildInfoCard(
                        icon: Icons.filter_list,
                        title: 'Filter',
                        description: 'Cut through the noise with powerful, precise filters. Search by cuisine, distance, vibe, price, and more — so every result feels made just for you.',
                        isMobile: isMobile,
                        context: context,
                      ),
                      _buildInfoCard(
                        icon: Icons.star,
                        title: 'Experience',
                        description: 'Go beyond reviews. Follow friends, share your Vibes, build top lists, plan trips, and let AI guide you to the perfect spot — every single time.',
                        isMobile: isMobile,
                        context: context,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String description,
    required bool isMobile,
    required BuildContext context,
  }) {
    final cardWidth = isMobile 
        ? (MediaQuery.of(context).size.width - 52)
        : 320.0;
    
    return Container(
      width: cardWidth,
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFF6EFE6).withOpacity(0.3),
          width: 0.5,
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(isMobile ? 12 : 16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFF6EFE6).withOpacity(0.2),
            ),
            child: Icon(
              icon,
              size: isMobile ? 24 : 32,
              color: const Color(0xFFF6EFE6),
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          Text(
            title,
            style: TextStyle(
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFF6EFE6),
            ),
          ),
          SizedBox(height: isMobile ? 8 : 12),
          Text(
            description,
            style: TextStyle(
              fontSize: isMobile ? 12 : 13,
              color: const Color(0xFFF6EFE6).withOpacity(0.8),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}