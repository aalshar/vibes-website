// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:vibes_website/main.dart';

void main() {
  testWidgets('Vibes website smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const VibesWebsite());

    // Verify that the app title appears
    expect(find.text('VIBES'), findsOneWidget);
    
    // Verify that key sections are present
    expect(find.text('About Vibes'), findsOneWidget);
    expect(find.text('Powerful Features'), findsOneWidget);
  });
}