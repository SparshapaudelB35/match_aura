import 'package:flutter/material.dart';
import 'package:match_aura/model/main_button.dart';

class OnBoarding extends StatelessWidget {
  final String title;
  final String subtitle;
  final String logoPath;
  final String onboardingImagePath;
  final String buttontext;
  final VoidCallback onNext; // Callback for Next button

  const OnBoarding({
    super.key,
    required this.title,
    required this.subtitle,
    required this.logoPath,
    required this.onboardingImagePath,
    required this.onNext,
    required this.buttontext
  });

  @override
  Widget build(BuildContext context) {
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

              Text(
                "Match Aura",
                style: TextStyle(fontSize: 36, color: Colors.white),
              ),

              const SizedBox(height: 40),
              Text(
                title,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFEE00),
                ),
              ),

              const SizedBox(height: 5),

              // Subtitle
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFEE00),
                ),
              ),

              const SizedBox(height: 5),

              const SizedBox(height: 20),

              // Onboarding image
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color of the card
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: const Offset(0, 5), // Shadow position
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        Transform.scale(
                          scale: 1,
                          child: Image.asset(
                            onboardingImagePath,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const Spacer(),
              MainButton(text: buttontext, onPressed: onNext),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
