import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticno_deta_recovery/screens/recover_screen.dart';

void main() {
  testWidgets('Recover Screen displays recovery buttons', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RecoverScreen()));

    // Check if all recovery buttons are present
    expect(find.text('Videos'), findsOneWidget);
    expect(find.text('Audios'), findsOneWidget);
    expect(find.text('Pictures'), findsOneWidget);
    expect(find.text('Documents'), findsOneWidget);
  });

  testWidgets('Recover Screen shows loading indicator when recovering', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: RecoverScreen()));

    // Trigger a button press
    await tester.tap(find.text('Videos'));
    await tester.pump();

    // Verify loading indicator appears
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
