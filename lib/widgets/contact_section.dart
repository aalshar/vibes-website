import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/colors.dart';
import '../utils/responsive.dart';
import '../widgets/animated_background.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendEmail() async {
    if (_formKey.currentState!.validate()) {
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: 'info@vibesappsa.com',
        query: 'subject=Contact from Vibes Website&body=Name: ${_nameController.text}\nEmail: ${_emailController.text}\n\nMessage:\n${_messageController.text}',
      );

      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.blue,
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Email client opened! Please send your message.',
                      style: TextStyle(color: AppColors.cream),
                    ),
                  ),
                ],
              ),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: Responsive.height(context),
      ),
      child: Stack(
        children: [
          // Animated dark cloudy background (same as Hero, About, Features, Screenshots)
          Positioned.fill(
            child: const AnimatedBackground(
              backgroundColor: Colors.black,
              isDark: true,
            ),
          ),
          
          // Subtle gradient overlay for depth
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.blue.withOpacity(0.1),
                  ],
                ),
              ),
            ),
          ),
          
          // Content
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20 : 80,
                  vertical: isMobile ? 40 : 60,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    children: [
                      Text(
                        'Get In Touch',
                        style: TextStyle(
                          fontSize: isMobile ? 28 : 48,
                          fontWeight: FontWeight.bold,
                          color: AppColors.cream,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: isMobile ? 8 : 12),
                      Text(
                        'Have questions? We\'d love to hear from you!',
                        style: TextStyle(
                          fontSize: isMobile ? 13 : 18,
                          color: AppColors.cream.withOpacity(0.9),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: isMobile ? 25 : 40),
                      
                      // Contact info cards - 3 in a row for iPhone
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: _buildContactCard(
                              icon: Icons.email,
                              title: 'Email',
                              subtitle: 'info@vibesappsa.com',
                              onTap: () async {
                                final Uri emailUri = Uri(
                                  scheme: 'mailto',
                                  path: 'info@vibesappsa.com',
                                );
                                if (await canLaunchUrl(emailUri)) {
                                  await launchUrl(emailUri);
                                }
                              },
                              isMobile: isMobile,
                            ),
                          ),
                          SizedBox(width: isMobile ? 8 : 20),
                          Expanded(
                            child: _buildContactCard(
                              icon: Icons.phone,
                              title: 'Phone',
                              subtitle: '+966 56 855 7274',
                              onTap: () async {
                                final Uri phoneUri = Uri(
                                  scheme: 'tel',
                                  path: '+966568557274',
                                );
                                if (await canLaunchUrl(phoneUri)) {
                                  await launchUrl(phoneUri);
                                }
                              },
                              isMobile: isMobile,
                            ),
                          ),
                          SizedBox(width: isMobile ? 8 : 20),
                          Expanded(
                            child: _buildContactCard(
                              icon: Icons.location_on,
                              title: 'Location',
                              subtitle: 'Riyadh, KSA',
                              onTap: () {},
                              isMobile: isMobile,
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: isMobile ? 25 : 40),
                      
                      // Contact form - transparent with cream styling
                      Container(
                        padding: EdgeInsets.all(isMobile ? 16 : 32),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(isMobile ? 20 : 24),
                          border: Border.all(
                            color: const Color(0xFFF6EFE6).withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Send us a message',
                                style: TextStyle(
                                  fontSize: isMobile ? 20 : 26,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFF6EFE6),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: isMobile ? 16 : 24),
                              
                              // Name field
                              TextFormField(
                                controller: _nameController,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFF6EFE6),
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Your Name',
                                  labelStyle: TextStyle(
                                    fontSize: isMobile ? 12 : 14,
                                    color: const Color(0xFFF6EFE6).withOpacity(0.7),
                                  ),
                                  hintText: 'Enter your name',
                                  hintStyle: TextStyle(
                                    fontSize: isMobile ? 12 : 14,
                                    color: const Color(0xFFF6EFE6).withOpacity(0.5),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person, 
                                    color: const Color(0xFFF6EFE6).withOpacity(0.7),
                                    size: isMobile ? 20 : 24,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(isMobile ? 10 : 12),
                                    borderSide: BorderSide(
                                      color: const Color(0xFFF6EFE6).withOpacity(0.3),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(isMobile ? 10 : 12),
                                    borderSide: BorderSide(
                                      color: const Color(0xFFF6EFE6).withOpacity(0.3),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.05),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(isMobile ? 10 : 12),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFF6EFE6),
                                      width: 2,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 10 : 16,
                                    vertical: isMobile ? 10 : 14,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: isMobile ? 12 : 16),
                              
                              // Email field
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFF6EFE6),
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Your Email',
                                  labelStyle: TextStyle(
                                    fontSize: isMobile ? 12 : 14,
                                    color: const Color(0xFFF6EFE6).withOpacity(0.7),
                                  ),
                                  hintText: 'Enter your email',
                                  hintStyle: TextStyle(
                                    fontSize: isMobile ? 12 : 14,
                                    color: const Color(0xFFF6EFE6).withOpacity(0.5),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.email, 
                                    color: const Color(0xFFF6EFE6).withOpacity(0.7),
                                    size: isMobile ? 20 : 24,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(isMobile ? 10 : 12),
                                    borderSide: BorderSide(
                                      color: const Color(0xFFF6EFE6).withOpacity(0.3),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(isMobile ? 10 : 12),
                                    borderSide: BorderSide(
                                      color: const Color(0xFFF6EFE6).withOpacity(0.3),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.05),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(isMobile ? 10 : 12),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFF6EFE6),
                                      width: 2,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 10 : 16,
                                    vertical: isMobile ? 10 : 14,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!value.contains('@')) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: isMobile ? 12 : 16),
                              
                              // Message field
                              TextFormField(
                                controller: _messageController,
                                maxLines: isMobile ? 3 : 4,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFF6EFE6),
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Your Message',
                                  labelStyle: TextStyle(
                                    fontSize: isMobile ? 12 : 14,
                                    color: const Color(0xFFF6EFE6).withOpacity(0.7),
                                  ),
                                  hintText: 'Type your message here...',
                                  hintStyle: TextStyle(
                                    fontSize: isMobile ? 12 : 14,
                                    color: const Color(0xFFF6EFE6).withOpacity(0.5),
                                  ),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(bottom: isMobile ? 40 : 60),
                                    child: Icon(
                                      Icons.message, 
                                      color: const Color(0xFFF6EFE6).withOpacity(0.7),
                                      size: isMobile ? 20 : 24,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(isMobile ? 10 : 12),
                                    borderSide: BorderSide(
                                      color: const Color(0xFFF6EFE6).withOpacity(0.3),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(isMobile ? 10 : 12),
                                    borderSide: BorderSide(
                                      color: const Color(0xFFF6EFE6).withOpacity(0.3),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.05),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(isMobile ? 10 : 12),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFF6EFE6),
                                      width: 2,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 10 : 16,
                                    vertical: isMobile ? 10 : 14,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your message';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: isMobile ? 16 : 24),
                              
                              // Submit button
                              ElevatedButton(
                                onPressed: _sendEmail,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFF6EFE6).withOpacity(0.15),
                                  foregroundColor: const Color(0xFFF6EFE6),
                                  padding: EdgeInsets.symmetric(
                                    vertical: isMobile ? 12 : 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(isMobile ? 10 : 12),
                                    side: BorderSide(
                                      color: const Color(0xFFF6EFE6).withOpacity(0.3),
                                      width: 1.5,
                                    ),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  'Send Message',
                                  style: TextStyle(
                                    fontSize: isMobile ? 14 : 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isMobile,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
      child: Container(
        padding: EdgeInsets.all(isMobile ? 10 : 20),
        decoration: BoxDecoration(
          color: AppColors.cream.withOpacity(0.15),
          borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
          border: Border.all(
            color: AppColors.cream.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: isMobile ? 24 : 36,
              color: AppColors.cream,
            ),
            SizedBox(height: isMobile ? 6 : 12),
            Text(
              title,
              style: TextStyle(
                fontSize: isMobile ? 12 : 16,
                fontWeight: FontWeight.bold,
                color: AppColors.cream,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: isMobile ? 3 : 6),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: isMobile ? 8 : 13,
                color: AppColors.cream.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}