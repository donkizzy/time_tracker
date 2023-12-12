// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_tracker.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeTrackerAdapter extends TypeAdapter<TimeTracker> {
  @override
  final int typeId = 1;

  @override
  TimeTracker read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeTracker(
      timeframes: fields[1] as Timeframes?,
      title: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TimeTracker obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.timeframes)
      ..writeByte(2)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeTrackerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
