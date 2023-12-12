import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:time_tracker/app/dashboard/data/models/timeframes_time.dart';

part 'time_frames.g.dart';

@HiveType(typeId: 2)
class Timeframes extends HiveObject with EquatableMixin{
  @HiveField(1)
  final Time? daily;
  @HiveField(2)
  final Time? monthly;
  @HiveField(3)
  final Time? weekly;

  Timeframes({
    this.daily,
    this.monthly,
    this.weekly,
  });

  factory Timeframes.fromJson(Map<String, dynamic> json) => Timeframes(
        daily: json["daily"] == null ? null : Time.fromJson(json["daily"]),
        monthly:
            json["monthly"] == null ? null : Time.fromJson(json["monthly"]),
        weekly: json["weekly"] == null ? null : Time.fromJson(json["weekly"]),
      );

  Map<String, dynamic> toJson() => {
        "daily": daily?.toJson(),
        "monthly": monthly?.toJson(),
        "weekly": weekly?.toJson(),
      };

  @override
  List<Object?> get props => [daily, monthly, weekly];
}
