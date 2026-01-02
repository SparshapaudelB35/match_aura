import 'package:flutter/material.dart';
import 'package:match_aura/features/onboarding/presentation/pages/on_boarding3.dart';
import 'package:match_aura/features/onboarding/presentation/widget/onboarding_widget.dart';

class OnBoarding2 extends StatefulWidget {
  const OnBoarding2({super.key});

  @override
  State<OnBoarding2> createState() => _OnBoarding2State();
}

class _OnBoarding2State extends State<OnBoarding2> {
  @override
  Widget build(BuildContext context) {
    return OnBoarding(
      title: "Express Your True Self",
      subtitle: "Create a unique aura profile that reflects your personality and lifestyle.",
      logoPath: "assets/images/logo.png",
      onboardingImagePath: "assets/images/onboarding2.jpg",
      buttontext: "Next",
      onNext: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const OnBoarding3()),
        );
      },
    );
  }
}
