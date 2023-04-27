// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart mode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddtoCartAdapter extends TypeAdapter<AddtoCart> {
  @override
  final int typeId = 1;

  @override
  AddtoCart read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddtoCart(
      name: fields[0] as String,
      email: fields[1] as String,
      phoneNumber: fields[2] as String,
      lat: fields[3] as String,
      long: fields[4] as String,
      location: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AddtoCart obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.phoneNumber)
      ..writeByte(3)
      ..write(obj.lat)
      ..writeByte(4)
      ..write(obj.long)
      ..writeByte(5)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddtoCartAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
