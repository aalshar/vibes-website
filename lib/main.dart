import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/landing_page.dart';
import 'constants/colors.dart';

void main() {
  runApp(const VibesWebsite());
}

class VibesWebsite extends StatelessWidget {
  const VibesWebsite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vibes - Discover Saudi Arabia\'s Best Restaurants',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
          background: AppColors.cream,
          primary: AppColors.blue,
          secondary: AppColors.cream,
        ),
        scaffoldBackgroundColor: AppColors.black,
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}