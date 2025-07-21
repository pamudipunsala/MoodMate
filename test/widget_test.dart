// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:moodmate/main.dart';

void main() {
  testWidgets('MoodMate app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    SharedPreferences.setMockInitialValues({});
    final sharedPreferences = await SharedPreferences.getInstance();
    await tester.pumpWidget(MyApp(sharedPreferences: sharedPreferences));

    // Verify that the app title is displayed
    expect(find.text('MoodMate'), findsOneWidget);

    // Verify that the welcome text is displayed
    expect(find.text('Welcome to'), findsOneWidget);

    // Verify that quick actions section exists
    expect(find.text('Quick Actions'), findsOneWidget);
  });
}
