import 'package:flutter/material.dart';
import 'package:match_aura/features/onboarding/presentation/pages/on_boarding2.dart';
import 'package:match_aura/features/onboarding/presentation/widget/onboarding_widget.dart';

class OnBoarding1 extends StatelessWidget {
  const OnBoarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoarding(
      title: "Discover Your Aura Match",
      subtitle: "A smarter way to meet people who share your vibe, energy, and interests.",
      logoPath: "assets/images/logo.png",
      onboardingImagePath: "assets/images/onboarding1.jpg",
      buttontext: "Next",
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const OnBoarding2()),
        );
      },
    );
  }
}
