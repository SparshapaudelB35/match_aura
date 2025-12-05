import 'package:flutter/material.dart';
import 'package:match_aura/model/main_button.dart';

class OnBoarding extends StatelessWidget {
  final String title;
  final String subtitle;
  final String logoPath;
  final String onboardingImagePath;
  final String buttontext;
  final VoidCallback onNext;

  const OnBoarding({
    super.key,
    required this.title,
    required this.subtitle,
    required this.logoPath,
    required this.onboardingImagePath,
    required this.onNext,
    required this.buttontext,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;

    // Max width and height for tablet
    final tabletMaxWidth = 500.0;
    final tabletMaxHeight = 300.0;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2), Color(0xFFDA22FF)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 50),

              // Logo
              Image.asset(logoPath, height: 140, fit: BoxFit.contain),
              const SizedBox(height: 10),

              const Text(
                "Match Aura",
                style: TextStyle(fontSize: 36, color: Colors.white),
              ),

              const SizedBox(height: 20),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFEE00),
                ),
              ),
              const SizedBox(height: 5),

              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFEE00),
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isTablet ? tabletMaxWidth : double.infinity,
                      maxHeight: isTablet ? tabletMaxHeight : screenHeight * 0.35,
                    ),
                    child: AspectRatio(
                      aspectRatio: 3 / 3, // adjust according to your image
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            onboardingImagePath,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Button at bottom
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: MainButton(
                  text: buttontext,
                  onPressed: onNext,
                ),
              ),

              const SizedBox(height: 13),
            ],
          ),
        ),
      ),
    );
  }
}
