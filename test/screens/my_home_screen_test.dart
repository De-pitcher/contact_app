import 'package:contact_app/data/hive_db.dart';
import 'package:contact_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

void main() async{
  
  HiveDb hiveDb = HiveDb(Hive);
  await hiveDb.initializeDb(); 
   Widget createWidget = const MaterialApp(
    home: Scaffold(body: MyApp()),
  );
  testWidgets('my home page ...', (tester) async {
    await tester.pumpWidget(createWidget);
    expect(find.text('Emmanuel'), findsOneWidget);
    // expect(find.text('Peters'), findsOneWidget);
    // expect(find.text('Favour'), findsOneWidget);
    // expect(find.text('Richard'), findsOneWidget);
  });
}