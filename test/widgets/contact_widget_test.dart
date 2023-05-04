import 'package:contact_app/models/group.dart';
import 'package:contact_app/widgets/contact_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidget = const MaterialApp(
    home: Scaffold(
      body: ContactWidget(
        group: Group.non,
        title: 'Testing the ContactWidget',
      ),
    ),
  );
  WidgetController.hitTestWarningShouldBeFatal = true;
  group('Contact Widget', () {
    testWidgets('contact widget ...', (tester) async {
      await tester.pumpWidget(createWidget);
      expect(find.text('FirstName'), findsOneWidget);
      expect(find.text('LastName'), findsOneWidget);
      expect(find.text('Phone'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('NON'), findsOneWidget);
    });
    testWidgets('Test the Textfields', (tester) async {
      await tester.pumpWidget(createWidget);
      await tester.tap(find.byKey(const Key('FirstName')));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.tap(find.byKey(const Key('LastName')));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.tap(find.byKey(const Key('Phone')));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.tap(find.byKey(const Key('Email')));
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });
  });
}
