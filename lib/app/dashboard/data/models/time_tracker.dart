import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:time_tracker/app/dashboard/data/models/time_frames.dart';


part 'time_tracker.g.dart';

@HiveType(typeId: 1)
class TimeTracker extends HiveObject with EquatableMixin {
  @HiveField(1)
  final Timeframes? timeframes;
  @HiveField(2)
  final String? title;

  TimeTracker({
    this.timeframes,
    this.title,
  });

  factory TimeTracker.fromJson(Map<String, dynamic> json) => TimeTracker(
        timeframes: json["timeframes"] == null
            ? null
            : Timeframes.fromJson(json["timeframes"]),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "timeframes": timeframes?.toJson(),
        "title": title,
      };

  @override
  List<Object?> get props => [timeframes, title];
}
