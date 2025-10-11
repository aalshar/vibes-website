import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/responsive.dart';
import 'package:google_fonts/google_fonts.dart';

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
  
  // Initialize with proper viewport fraction after first frame
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final isMobile = Responsive.isMobile(context);
    _pageController = PageController(
      viewportFraction: isMobile ? 0.85 : 0.25,
      initialPage: 4,
    );
    
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
    
    setState(() {});
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
    
return Container(
  width: double.infinity,
  height: Responsive.height(context),
  color: AppColors.black,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 50,
              left: isMobile ? 24 : 80,
              right: isMobile ? 24 : 80,
              bottom: 20,
            ),
            child: Column(
              children: [
                Text(
                  'See It In Action',
                  style: TextStyle(
                    fontSize: isMobile ? 32 : 48,
                    fontWeight: FontWeight.bold,
                    color: AppColors.cream,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
child: Text(
  _screenshotDescriptions[_currentPage],
  key: ValueKey<int>(_currentPage),
 style: GoogleFonts.lilitaOne(
    fontSize: isMobile ? 16 : 20,
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
          
          // Carousel
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: 10,
              itemBuilder: (context, index) {
                return _buildCarouselItem(index, isMobile);
              },
            ),
          ),
          
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildCarouselItem(int index, bool isMobile) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 1.0;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page! - index;
          value = (1 - (value.abs() * 0.6)).clamp(0.5, 1.0);
        }
        
return Center(
  child: SizedBox(
    height: Curves.easeOut.transform(value) * (isMobile ? 500 : 650),
    width: Curves.easeOut.transform(value) * (isMobile ? 280 : 380),
    child: child,
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
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
              color: AppColors.cream.withOpacity(0.2),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.blue.withOpacity(0.3),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Transform.scale(
              scale: 0.95,
              child: Image.asset(
                'assets/screenshot_${index + 1}.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}