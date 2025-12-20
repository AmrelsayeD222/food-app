// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:foods_app/main.dart';

void main() {
  testWidgets('App loads and displays ProductDetalisView',
      (WidgetTester tester) async {
    // Define the isLoggedIn variable (for example: set it to true for testing)
    const bool isLoggedIn = true;

    // Build our app and trigger a frame.
    await tester.pumpWidget(const HungryApp(isLoggedIn: isLoggedIn));

    // Verify that the app loads successfully
    expect(find.byType(MaterialApp), findsOneWidget);

    // Verify that ProductDetalisView is displayed (it has an AppBar with back button)
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });
}
