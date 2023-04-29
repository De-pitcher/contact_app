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

@GenerateMocks([MockHiveBox])
@GenerateMocks([MockHiveInterface])
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

      when(hiveInterface.isBoxOpen(permissionStatusBoxName)).thenReturn(true);
      when(hiveInterface.box<bool>(permissionStatusBoxName))
          .thenAnswer((_) => permissonBox);
      when(permissonBox.get(permissionStatusBoxName))
          .thenAnswer((realInvocation) => answer);

      /// Act
      hiveDb.getPermission();

      /// Assert
      verify(hiveInterface.isBoxOpen(permissionStatusBoxName));
      verify(hiveInterface.box<bool>(permissionStatusBoxName));
      verify(permissonBox.get(permissionStatusBoxName));
    });

    test('getPermisison to fail', () async {
      /// Arrange
      final permissonBox = MockMockHiveBox<bool>();
      const fakePermissionBoxName = 'permissionStatusBoxName';

      when(hiveInterface.isBoxOpen(fakePermissionBoxName)).thenReturn(false);
      when(hiveInterface.box<bool>(fakePermissionBoxName))
          .thenThrow(Exception('This box does not exist'));
      when(permissonBox.get(fakePermissionBoxName)).thenReturn(null);

      /// Act
      hiveDb.getPermission(fakePermissionBoxName);

      /// Assert
      verify(hiveInterface.isBoxOpen(fakePermissionBoxName));
      verifyNever(hiveInterface.box<bool>(fakePermissionBoxName)).called(0);
      verifyNever(permissonBox.get(fakePermissionBoxName)).called(0);
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
      when(hiveInterface.isBoxOpen(contactsBoxName)).thenReturn(true);
      when(hiveInterface.box<Contact>(contactsBoxName))
          .thenAnswer((_) => contactBox);
      when(contactBox.values).thenAnswer((_) => contacts);

      /// Act
      hiveDb.getContacts();

      /// Assert
      verify(hiveInterface.isBoxOpen(contactsBoxName));
      verify(hiveInterface.box<Contact>(contactsBoxName));
      verify(contactBox.values);
    });

    test('getCotacts() to fail', () async {
      /// Arrange
      const fakeContactBoxName = 'contactsBoxName';

      when(hiveInterface.isBoxOpen(fakeContactBoxName)).thenReturn(false);
      when(hiveInterface.box<Contact>(fakeContactBoxName))
          .thenThrow(Exception('This box does not exist'));

      /// Act
      hiveDb.getContacts(fakeContactBoxName);

      /// Assert
      verify(hiveInterface.isBoxOpen(fakeContactBoxName)).called(1);
      verifyNever(hiveInterface.box<Contact>(fakeContactBoxName));
    });
  });
}
