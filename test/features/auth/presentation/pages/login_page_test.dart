import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_aura/features/auth/presentation/pages/login_page.dart';


void main() {
  Widget createTestWidget() {
    return ProviderScope(
      child: MaterialApp(
        home: const LoginPage(),
      ),
    );
  }

  group('LoginPage Widget Tests', () {
    testWidgets('renders email, password fields and login button', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check for email & password fields
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.widgetWithText(TextFormField, 'Email'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);

      // Check login button
      expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);

      // Check social login buttons
      expect(find.text('Login with Google'), findsOneWidget);
      expect(find.text('Login with Phone'), findsOneWidget);
    });

    testWidgets('allows entering email and password', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final emailField = find.widgetWithText(TextFormField, 'Email');
      final passwordField = find.widgetWithText(TextFormField, 'Password');

      await tester.enterText(emailField, 'test@example.com');
      await tester.enterText(passwordField, 'password123');
      await tester.pump();

      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.text('password123'), findsOneWidget);
    });

    testWidgets('shows forgot password button', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final forgotPasswordButton = find.text('Forgot Password?');
      expect(forgotPasswordButton, findsOneWidget);
    });

    testWidgets('login button can be tapped', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final loginButton = find.widgetWithText(ElevatedButton, 'Login');
      await tester.tap(loginButton);
      await tester.pump();

      // Since actual login logic is async, we just test that the button exists & can be tapped
      expect(loginButton, findsOneWidget);
    });
  });
}
