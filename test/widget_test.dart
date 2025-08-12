// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:minhas_ideias/main.dart';

void main() {
  testWidgets('App starts correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MinhasIdeiasApp());

    // Verify that our app has the main navigation buttons.
    expect(find.text('Nova Ideia'), findsOneWidget);
    expect(find.text('Minhas Ideias'), findsWidgets);
  });
}
