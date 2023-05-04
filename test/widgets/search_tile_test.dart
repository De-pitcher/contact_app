import 'package:contact_app/widgets/contact_tile.dart';
import 'package:contact_app/widgets/search_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../constants.dart';

void main() {
  Widget createWidget = MaterialApp(
    home: Scaffold(
      body: SearchTile(contacts: contacts),
    ),
  );

  group('Search Tile Widget Tests', () {
    testWidgets('Test if [ListTile] for the SearchTile shows up',
        (tester) async {
      await tester.pumpWidget(createWidget);
      expect(find.byType(ListTile), findsOneWidget);
    });
  });
  testWidgets('Test if [ListView] for the Delegate shows up', (tester) async {
    await tester.pumpWidget(createWidget);

    await tester.tap(find.byType(ListTile));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(tester.widgetList(find.byType(ContactTile)).length,
        lessThan(contacts.length));
  });

  testWidgets('Search for a Contact and return back to the Home Page',
      (tester) async {
    await tester.pumpWidget(createWidget);

    await tester.tap(find.byType(ListTile));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Emma');
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text('Emmanuel'), findsOneWidget);
    expect(find.text('Richard'), findsNothing);

    await tester.tap(find.byIcon(Icons.clear));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.byType(TextField), findsNothing);
  });
}
