import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ticno_deta_recovery/main.dart';

void main() {
  testWidgets('Ticno Deta Recovery renders Home Screen', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(TicnoDetaRecoveryApp());

    // Verify Home Screen text and buttons
    expect(find.text('Recover Your Deleted Data'), findsOneWidget);
    expect(find.text('Recover Data'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });
}
