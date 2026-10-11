import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:roll_the_dice/main.dart';

void main() {
  testWidgets('Roll button shows a dice image', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: DiceRoller()));

    expect(find.byType(Image), findsOneWidget);
    expect(find.text('Hoď kockou'), findsOneWidget);

    await tester.tap(find.text('Hoď kockou'));
    await tester.pump();

    expect(find.byType(Image), findsOneWidget);
  });
}
