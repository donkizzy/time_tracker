import 'package:hive_flutter/hive_flutter.dart';
import 'package:time_tracker/app/dashboard/data/models/time_tracker.dart';

class HiveService   {

  Future<void> addTasks({required List<TimeTracker> timeTracker}) async {
    final box = await Hive.openBox<TimeTracker>('taskBox');
    box.addAll(timeTracker);
  }

  Future<void> addTask({required TimeTracker timeTracker}) async {
    final box = await Hive.openBox<TimeTracker>('taskBox');
    box.add(timeTracker);
  }


  Future<List<TimeTracker>> getTasks() async {
    final box = await Hive.openBox<TimeTracker>('taskBox');
    final todos = box.values.toList();
    return todos;
  }

}