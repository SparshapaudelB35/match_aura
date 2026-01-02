import 'package:flutter/material.dart';
import 'package:match_aura/features/onboarding/presentation/pages/on_boarding1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isTablet = constraints.maxWidth >= 600;
          final double screenHeight = constraints.maxHeight;

          final double logoSize = isTablet ? screenHeight * 0.16 : 140;
          final double titleFontSize = isTablet ? 40 : 36;
          final double imageWidth =
              isTablet ? constraints.maxWidth * 0.22 : constraints.maxWidth * 0.4;

          return Container(
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
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: isTablet ? 16 : 12,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            width: logoSize,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Match Aura",
                            style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 32 : 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/design.png",
                            width: imageWidth,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(width: isTablet ? 28 : 20),
                          Image.asset(
                            "assets/images/design2.png",
                            width: imageWidth,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: isTablet ? 24 : 16,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OnBoarding1(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: isTablet ? 24 : 16,
                              vertical: isTablet ? 14 : 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            elevation: 6,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Start Matching",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: isTablet ? 22 : 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Container(
                                width: isTablet ? 56 : 48,
                                height: isTablet ? 56 : 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF4A00E0),
                                      Color(0xFF8E2DE2),
                                      Color(0xFFDA22FF),
                                    ],
                                  ),
                                ),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
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
            ),
          );
        },
      ),
    );
  }
}
