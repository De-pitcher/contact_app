import 'package:contact_app/data/hive_db.dart';
import 'package:contact_app/data/hive_db_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mockito/annotations.dart';

// Annotation which generates the cat.mocks.dart library and the MockCat class.
@GenerateNiceMocks([MockSpec<HiveDbRepository>()])
// import 'hive_db_repository.mocks.dart';

@GenerateNiceMocks([MockSpec<HiveDb>()])
// import 'hive_db.mocks.dart';


void main() {

setUp(() async {
  await setUpTestHive();
});
}