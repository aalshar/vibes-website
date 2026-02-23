import 'package:flutter/material.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/features_section.dart';
import '../widgets/screenshots_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/flying_icon.dart';
import '../widgets/animated_background.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      final screenHeight = MediaQuery.of(context).size.height;
      final currentScroll = _scrollController.offset;
      final progress = (currentScroll / screenHeight).clamp(0.0, 1.0);
      setState(() {
        _scrollProgress = progress;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fixed background — stays in place while content scrolls
          Positioned.fill(
            child: AnimatedBackground(
              backgroundColor: Colors.black,
              isDark: true,
            ),
          ),

          // Scrollable content on top
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: const [
                HeroSection(),
                AboutSection(),
                FeaturesSection(),
                ScreenshotsSection(),
                ContactSection(),
                FooterSection(),
              ],
            ),
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