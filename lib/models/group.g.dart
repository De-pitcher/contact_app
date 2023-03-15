// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroupAdapter extends TypeAdapter<Group> {
  @override
  final int typeId = 1;

  @override
  Group read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Group.family;
      case 1:
        return Group.favorite;
      case 2:
        return Group.custom;
      case 3:
        return Group.non;
      default:
        return Group.family;
    }
  }

  @override
  void write(BinaryWriter writer, Group obj) {
    switch (obj) {
      case Group.family:
        writer.writeByte(0);
        break;
      case Group.favorite:
        writer.writeByte(1);
        break;
      case Group.custom:
        writer.writeByte(2);
        break;
      case Group.non:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
