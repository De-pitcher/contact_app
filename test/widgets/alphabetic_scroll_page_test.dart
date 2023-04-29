import 'package:contact_app/widgets/alphabetic_scroll_page.dart';
import 'package:contact_app/widgets/contact_details_widget.dart';
import 'package:contact_app/widgets/contact_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../constants.dart';

void main() {
  Widget createWidget = MaterialApp(
    home: Scaffold(
      body: AlphabeticScrollPage(contacts: contacts),
    ),
  );
  testWidgets('alphabetic scroll page ...', (tester) async {
    await tester.pumpWidget(createWidget);
    expect(find.text('Austine'), findsOneWidget);
    expect(find.text('Emmanuel'), findsOneWidget);
    expect(find.text('Edmond'), findsOneWidget);
    await tester.fling(
      find.byType(ScrollablePositionedList),
      const Offset(0, -200),
      3000,
    );

    await tester.pumpAndSettle();
    expect(find.text('Richard'), findsOneWidget);

    await tester.tap(find.text('Richard'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.byType(ScrollablePositionedList), findsNothing);
    expect(find.byType(ContactDetailsWidget), findsOneWidget);
  });
}
