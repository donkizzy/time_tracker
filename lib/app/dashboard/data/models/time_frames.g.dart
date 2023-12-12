// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_frames.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeframesAdapter extends TypeAdapter<Timeframes> {
  @override
  final int typeId = 2;

  @override
  Timeframes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Timeframes(
      daily: fields[1] as Time?,
      monthly: fields[2] as Time?,
      weekly: fields[3] as Time?,
    );
  }

  @override
  void write(BinaryWriter writer, Timeframes obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.daily)
      ..writeByte(2)
      ..write(obj.monthly)
      ..writeByte(3)
      ..write(obj.weekly);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeframesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
