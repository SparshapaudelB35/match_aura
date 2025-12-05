import 'package:flutter/material.dart';
import 'package:match_aura/screens/signup_screen.dart';
import 'package:match_aura/widget/onboarding_widget.dart';

class OnBoarding3 extends StatefulWidget {
  const OnBoarding3({super.key});

  @override
  State<OnBoarding3> createState() => _OnBoarding3State();
}

class _OnBoarding3State extends State<OnBoarding3> {
  @override
  Widget build(BuildContext context) {
     return OnBoarding(
      title: "Match • Connect • Chat",
      subtitle: "Engage in real-time conversations and build meaningful connections.",
      logoPath: "assets/images/logo.png",
      onboardingImagePath: "assets/images/onboarding3.jpg",
      buttontext: "Sign Up",
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SignupScreen()),
        );
      },
    );
  }
}
