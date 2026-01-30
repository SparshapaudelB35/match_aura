import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_aura/features/profile_setup/presentation/pages/profiledetail.dart';

void main() {
  Widget createTestWidget() {
    return ProviderScope(
      child: MaterialApp(
        home: const ProfileDetailsPage(),
      ),
    );
  }

  group('ProfileDetailsPage - UI Elements', () {
    testWidgets('should render all text fields and button', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Check for all text fields
      expect(find.byType(TextField), findsNWidgets(3)); // First, Last, Bio

      // Check for Birth Date picker container
      expect(find.text('Choose Birth Date'), findsOneWidget);

      // Confirm button
      expect(find.text('Confirm'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should allow entering text in text fields', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final firstNameField = find.widgetWithText(TextField, 'First Name');
      final lastNameField = find.widgetWithText(TextField, 'Last Name');
      final bioField = find.widgetWithText(TextField, 'Bio');

      await tester.enterText(firstNameField, 'John');
      await tester.enterText(lastNameField, 'Doe');
      await tester.enterText(bioField, 'This is a bio');

      await tester.pump();

      expect(find.text('John'), findsOneWidget);
      expect(find.text('Doe'), findsOneWidget);
      expect(find.text('This is a bio'), findsOneWidget);
    });

    testWidgets('should allow selecting date', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final datePicker = find.text('Choose Birth Date');
      await tester.tap(datePicker);
      await tester.pumpAndSettle();

      // Pick a date using showDatePicker
      final okButton = find.text('OK');
      if (okButton.evaluate().isNotEmpty) {
        await tester.tap(okButton);
        await tester.pumpAndSettle();
      }

      // After picking a date, text should change
      expect(find.textContaining('/'), findsOneWidget);
    });
  });
}
