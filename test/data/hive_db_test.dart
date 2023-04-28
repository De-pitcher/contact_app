import 'package:contact_app/constants/constants.dart';
import 'package:contact_app/data/hive_db.dart';
import 'package:contact_app/data/hive_db_repository.dart';
import 'package:contact_app/models/contact.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'constants.dart';
import 'hive_db_test.mocks.dart';

class MockHiveBox<T> extends Mock implements Box<T> {}

class MockHiveInterface extends Mock implements HiveInterface {}

class MockHiveDb extends Mock implements HiveDb {}

@GenerateMocks([MockHiveBox])
@GenerateMocks([MockHiveInterface])
@GenerateMocks([MockHiveDb])
void main() {
  setUp(() async {
    await setUpTestHive();
  });
  MockHiveInterface hiveInterface = MockMockHiveInterface();

  Box hiveBox = MockMockHiveBox();

  HiveDbRepository hiveDb = HiveDb(hiveInterface);

  group('HiveDb class', () {
    group('test setPermission()', () {
      /// arrange(open the box)
      test('set the permission to pass', () async {
        /// Arrange
        when(hiveInterface.openBox(permissionStatusBoxName))
            .thenAnswer((realInvocation) async => hiveBox);

        /// Act
        hiveDb.setPermission(true);

        /// Assert
        verify(hiveInterface.openBox(permissionStatusBoxName));
      });
    });
  });
  group('test getPermission()', () {
    test('getPermisison to pass', () async {
      /// Arrange
      final permissonBox = MockMockHiveBox<bool>();
      bool? answer = true;

      when(hiveInterface.box<bool>(permissionStatusBoxName))
          .thenAnswer((_) => permissonBox);
      when(permissonBox.get(permissionStatusBoxName))
          .thenAnswer((realInvocation) => answer);

      /// Act
      hiveDb.getPermission();

      /// Assert
      verify(hiveInterface.box<bool>(permissionStatusBoxName));
      verify(permissonBox.get(permissionStatusBoxName));
    });
  });

  group('initializeContacts()', () {
    test('initialize contacts to pass', () async {
      /// Arrange
      final contactBox = MockMockHiveBox<Contact>();

      when(hiveInterface.openBox<Contact>(contactsBoxName))
          .thenAnswer((_) async => contactBox);

      /// Act
      hiveDb.initializeContact(contacts);

      /// Assert
      verify(hiveInterface.openBox(contactsBoxName));
    });
  });

  group('test getContacts()', () {
    test('getCotacts() to pass', () async {
      /// Arrange
      final contactBox = MockMockHiveBox<Contact>();
      when(hiveInterface.box<Contact>(contactsBoxName))
          .thenAnswer((realInvocation) => contactBox);
      when(contactBox.values).thenAnswer((_) => contacts);

      /// Act
      hiveDb.getContacts();

      /// Assert
      verify(hiveInterface.box<Contact>(contactsBoxName));
    });
  });
}
