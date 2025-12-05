import 'package:flutter/material.dart';
import 'package:match_aura/screens/on_boarding1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2), Color(0xFFDA22FF)],
          ),
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 80),
              Image.asset('assets/images/logo.png', width: 140),
              const SizedBox(height: 10),
              const Text(
                "Match Aura",
                style: TextStyle(fontSize: 36, color: Colors.white),
              ),

              const SizedBox(height: 100),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/design.png",
                    width: 190,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 20),
                  Image.asset(
                    "assets/images/design2.png",
                    width: 180,
                    fit: BoxFit.contain,
                  ),
                ],
              ),

              const Spacer(),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OnBoarding1()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Start Matching",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
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

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
