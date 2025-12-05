import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 700,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 146, 146, 146),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/image.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 35),
                        Image.asset('assets/images/logo.png', width: 140),
                        const SizedBox(height: 10),
                        const Text(
                          "Match Aura",
                          style: TextStyle(
                            fontSize: 36,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 70),
                        const Text(
                          "Swipe Right",
                          style: TextStyle(
                            fontSize: 48,
                            color: Color(0xFFFFEE00),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "Match Vibe!",
                          style: TextStyle(
                            fontSize: 48,
                            color: Color(0xFFFFEE00),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 50),

                        _buildSocialLoginButton(
                          text: 'Login with Google',
                          icon: Icons.g_mobiledata,
                          color: const Color.fromARGB(255, 235, 19, 19),
                          logocolor: Color.fromARGB(255, 235, 19, 19),
                          onTap: () {
                            // Add Google login logic here
                          },
                        ),

                        SizedBox(height: 20),
                        _buildSocialLoginButton(
                          text: 'Login with Facebook',
                          icon: Icons.facebook,
                          color: Colors.blue,
                          logocolor: Colors.blue,
                          onTap: () {
                            // Add Facebook login logic here
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            _buildSocialLoginButton(
              text: 'Login with Phone',
              icon: Icons.phone,
              color: Colors.purple.shade700,
              logocolor: Colors.purple.shade700,
              onTap: () {},
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLoginButton({
    required String text,
    required IconData icon,
    required Color color,
    required Color logocolor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 300,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: logocolor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, size: 30, color: Colors.white),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
