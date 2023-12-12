// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeframes_time.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeAdapter extends TypeAdapter<Time> {
  @override
  final int typeId = 3;

  @override
  Time read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Time(
      current: fields[1] as int?,
      previous: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Time obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.current)
      ..writeByte(2)
      ..write(obj.previous);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
