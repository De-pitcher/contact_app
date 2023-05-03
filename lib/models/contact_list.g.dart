// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactListAdapter extends TypeAdapter<ContactList> {
  @override
  final int typeId = 2;

  @override
  ContactList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContactList(
      (fields[0] as List).cast<Contact>(),
    );
  }

  @override
  void write(BinaryWriter writer, ContactList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.contacts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
