import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/responsive.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: screenHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                AppColors.cream,
                AppColors.cream.withOpacity(0.8),
              ],
            ),
          ),
        ),
        
        // Noise texture overlay
        Positioned.fill(
          child: Opacity(
            opacity: 0.15,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://www.transparenttextures.com/patterns/45-degree-fabric-light.png',
                  ),
                  repeat: ImageRepeat.repeat,
                  opacity: 0.3,
                ),
              ),
            ),
          ),
        ),
        
        Center(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 80,
                vertical: isMobile ? 30 : 60,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Powerful Features',
                      style: TextStyle(
                        fontSize: isMobile ? 26 : 48,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: isMobile ? 8 : 16),
                    Text(
                      'Everything you need to find your perfect dining experience',
                      style: TextStyle(
                        fontSize: isMobile ? 12 : 18,
                        color: AppColors.textDark.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: isMobile ? 20 : 40),
                    
                    Wrap(
                      spacing: isMobile ? 10 : 20,
                      runSpacing: isMobile ? 10 : 20,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildFeatureCard(
                          icon: Icons.smart_toy,
                          title: 'Vibes AI',
                          description: 'Chat with our AI assistant to discover restaurants tailored to your preferences.',
                          isMobile: isMobile,
                          context: context,
                        ),
                        _buildFeatureCard(
                          icon: Icons.emoji_events,
                          title: 'Vibes Best',
                          description: 'Explore top 10 rankings based on authentic ratings and reviews.',
                          isMobile: isMobile,
                          context: context,
                        ),
                        _buildFeatureCard(
                          icon: Icons.tune,
                          title: 'Smart Filters',
                          description: 'Filter by cuisine, location, features, and price range.',
                          isMobile: isMobile,
                          context: context,
                        ),
                        _buildFeatureCard(
                          icon: Icons.people,
                          title: 'Social Features',
                          description: 'Connect with friends and share recommendations.',
                          isMobile: isMobile,
                          context: context,
                        ),
                        _buildFeatureCard(
                          icon: Icons.star_rate,
                          title: 'Real Reviews',
                          description: 'Read genuine reviews from real diners.',
                          isMobile: isMobile,
                          context: context,
                        ),
                        _buildFeatureCard(
                          icon: Icons.location_on,
                          title: 'Location Based',
                          description: 'Find restaurants near you across Saudi Arabia.',
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
      ],
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required bool isMobile,
    required BuildContext context,
  }) {
    final cardWidth = isMobile 
        ? (MediaQuery.of(context).size.width - 52)
        : 340.0;
    
    return Container(
      width: cardWidth,
      padding: EdgeInsets.all(isMobile ? 12 : 24),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.black.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: isMobile ? 28 : 40,
            color: AppColors.blue,
          ),
          SizedBox(height: isMobile ? 8 : 16),
          Text(
            title,
            style: TextStyle(
              fontSize: isMobile ? 16 : 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: isMobile ? 6 : 10),
          Text(
            description,
            style: TextStyle(
              fontSize: isMobile ? 11 : 13,
              color: AppColors.textDark.withOpacity(0.7),
              height: 1.3,
            ),
            maxLines: isMobile ? 2 : 4,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}