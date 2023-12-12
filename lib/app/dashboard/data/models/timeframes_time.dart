import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

part 'timeframes_time.g.dart';

@HiveType(typeId: 3)
class Time extends HiveObject with EquatableMixin{
  @HiveField(1)
  final int? current;
  @HiveField(2)
  final int? previous;

  Time({
    this.current,
    this.previous,
  });

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        current: json["current"],
        previous: json["previous"],
      );

  Map<String, dynamic> toJson() => {
        "current": current,
        "previous": previous,
      };


  @override
  List<Object?> get props => [current, previous];
}
