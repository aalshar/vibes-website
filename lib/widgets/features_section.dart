import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/responsive.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
  final isMobile = Responsive.isMobile(context);
  
return Stack(
  children: [
    Container(
      width: double.infinity,
      height: Responsive.height(context),
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
      
      SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : 80,
              vertical: 60,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1400),
              child: Column(
                children: [
                  Text(
                    'Powerful Features',
                    style: TextStyle(
                      fontSize: isMobile ? 32 : 48,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Everything you need to find your perfect dining experience',
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 18,
                      color: AppColors.textDark.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
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
  return Container(
    width: isMobile ? (MediaQuery.of(context).size.width - 48) : 340,
    height: 200, // Add fixed height
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
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
            size: 40, // Reduced from 48
            color: AppColors.blue,
          ),
          const SizedBox(height: 16), // Reduced from 20
          Text(
            title,
            style: const TextStyle(
              fontSize: 20, // Reduced from 24
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 10), // Reduced from 12
          Text(
            description,
            style: TextStyle(
              fontSize: 13, // Reduced from 14
              color: AppColors.textDark.withOpacity(0.7),
              height: 1.5, // Reduced from 1.6
            ),
            maxLines: 4, // Limit lines
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}