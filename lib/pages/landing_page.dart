import 'package:flutter/material.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/features_section.dart';
import '../widgets/screenshots_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/flying_icon.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _pageController = PageController();
  double _scrollProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageScroll);
  }

  void _onPageScroll() {
    if (_pageController.hasClients) {
      // Get the current page position (0.0 to 1.0 for first to second page)
      final page = _pageController.page ?? 0.0;
      final progress = page.clamp(0.0, 1.0);
      
      setState(() {
        _scrollProgress = progress;
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView for snap scrolling
          PageView(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            children: const [
              HeroSection(),
              AboutSection(),
              FeaturesSection(),
              ScreenshotsSection(),
              ContactSection(),
              FooterSection(),
            ],
          ),
          
          // Flying icon overlay
          FlyingIcon(
            scrollProgress: _scrollProgress,
            screenSize: MediaQuery.of(context).size,
          ),
        ],
      ),
    );
  }
}