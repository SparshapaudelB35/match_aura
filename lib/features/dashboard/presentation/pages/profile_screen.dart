import 'package:flutter/material.dart';
import 'package:match_aura/app/routes/app_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_aura/core/services/storage/user_session_service.dart';
import 'package:match_aura/features/splash/presentation/pages/splash_screen.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth >= 600;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: isTablet ? 300 : 200,
          height: 55,
          child: ElevatedButton(
            onPressed: () {
                _showLogoutDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text(
              "Log Out",
              style: TextStyle(
                fontSize: 18, 
                color: Colors.white, 
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
      
    );
  }
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Logout',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              // Clear user session data
              final userSessionService = ref.read(UserSessionServiceProvider);
              await userSessionService.clearUserSession();
              // Navigate to splash screen
              AppRoutes.pushAndRemoveUntil(context, const SplashScreen());
            },
            child: Text(
              'Logout',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}