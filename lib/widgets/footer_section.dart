import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/colors.dart';
import '../utils/responsive.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({Key? key}) : super(key: key);

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 60,
      ),
      color: const Color(0xFF0a0a0a),
      child: Column(
        children: [
          // Logo (same as Hero section)
          Image.asset(
            'assets/Logo-10.png',
            height: 70,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 16),
          Text(
            'Discover. Experience. Share.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 40),
          
          // Social media icons
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _buildSocialButton(
                icon: Icons.language,
                label: 'Website',
                onPressed: () => _launchURL('https://example.com'),
              ),
              _buildSocialButton(
                icon: Icons.email,
                label: 'Email',
                onPressed: () => _launchURL('mailto:info@vibesappsa.com'),
              ),
              _buildSocialButton(
                icon: Icons.phone,
                label: 'Instagram',
                onPressed: () => _launchURL('https://instagram.com/yourhandle'),
              ),
              _buildSocialButton(
                icon: Icons.facebook,
                label: 'Twitter',
                onPressed: () => _launchURL('https://twitter.com/yourhandle'),
              ),
            ],
          ),
          
          const SizedBox(height: 40),
          
          // Divider
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.white.withOpacity(0.1),
          ),
          
          const SizedBox(height: 30),
          
          // Copyright and links
          Wrap(
            spacing: 30,
            runSpacing: 15,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                '© 2025 Vibes. All rights reserved.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 14,
                ),
              ),
              _buildFooterLink('Privacy Policy', () {}),
              _buildFooterLink('Terms of Service', () {}),
              _buildFooterLink('Contact Us', () {}),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Made with love
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Made with ',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 12,
                ),
              ),
              const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 16,
              ),
              Text(
                ' in Saudi Arabia',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.1),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildFooterLink(String text, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontSize: 14,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}