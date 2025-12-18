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
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isTablet = constraints.maxWidth >= 600;
          final double screenHeight = constraints.maxHeight;

          // Sizes dynamically based on tablet or mobile
          final double logoSize = isTablet ? screenHeight * 0.12 : 100;
          final double appNameSize = isTablet ? 34 : 28;
          final double titleSize = isTablet ? 26 : 22;
          final double subtitleSize = isTablet ? 18 : 14;

          final double imageMaxWidth = isTablet ? 480 : constraints.maxWidth * 0.9;
          final double imageMaxHeight =
              isTablet ? screenHeight * 0.32 : screenHeight * 0.28;

          return Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF4A00E0),
                  Color(0xFF8E2DE2),
                  Color(0xFFDA22FF),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          logoPath,
                          height: logoSize,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: isTablet ? 8 : 6),
                        Text(
                          "Match Aura",
                          style: TextStyle(
                            fontSize: appNameSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: isTablet ? 40 : 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: titleSize,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFFFEE00),
                            ),
                          ),
                          SizedBox(height: isTablet ? 10 : 6),
                          Text(
                            subtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: subtitleSize,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFFFEE00),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 16),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: imageMaxWidth,
                            maxHeight: imageMaxHeight,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
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

                  
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24)
                          .copyWith(bottom: isTablet ? 20 : 14),
                      child: Align(
                        alignment: Alignment.center,
                        child: MainButton(
                          text: buttontext,
                          onPressed: onNext,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
