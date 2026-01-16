import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_aura/app/routes/app_routes.dart';
import 'package:match_aura/core/services/storage/user_session_service.dart';
import 'package:match_aura/features/dashboard/presentation/pages/home_screen.dart';
import 'package:match_aura/features/onboarding/presentation/pages/on_boarding1.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _isLoggedIn = false;
  bool _isCheckingSession = true;

  @override
  void initState() {
    super.initState();
    _checkSessionAndNavigate();
  }

  Future<void> _checkSessionAndNavigate() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    final userSessionService = ref.read(UserSessionServiceProvider);
    final isLoggedIn = userSessionService.isLoggedIn();

    setState(() {
      _isLoggedIn = isLoggedIn;
      _isCheckingSession = false;
    });

    if (isLoggedIn) {
      AppRoutes.pushReplacement(context, const HomeScreen());
    }
  }

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
                  // LOGO
                  Expanded(
                    flex: 2,
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

                  // IMAGES
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
                          ),
                          SizedBox(width: isTablet ? 28 : 20),
                          Image.asset(
                            "assets/images/design2.png",
                            width: imageWidth,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // LOADING BAR OR BUTTON
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: isTablet ? 24 : 16,
                        left: isTablet ? 48 : 24,
                        right: isTablet ? 48 : 24,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: _isCheckingSession
                            ? const SizedBox.shrink()
                            : _isLoggedIn
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      LinearProgressIndicator(
                                        minHeight: 6,
                                        backgroundColor:
                                            Colors.white30,
                                        valueColor:
                                            AlwaysStoppedAnimation(
                                          Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      
                                    ],
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const OnBoarding1(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            isTablet ? 24 : 16,
                                        vertical:
                                            isTablet ? 14 : 10,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18),
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
                                            fontSize:
                                                isTablet ? 22 : 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Container(
                                          width: isTablet ? 56 : 48,
                                          height: isTablet ? 56 : 48,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            gradient:
                                                const LinearGradient(
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
