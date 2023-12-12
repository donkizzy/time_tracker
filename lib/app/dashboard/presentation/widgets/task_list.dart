
import 'package:flutter/material.dart';
import 'package:time_tracker/app/dashboard/data/models/time_enum.dart';
import 'package:time_tracker/app/dashboard/data/models/time_tracker.dart';
import 'package:time_tracker/app/dashboard/presentation/widgets/task_item.dart';

class TaskList extends StatefulWidget {
  final List<TimeTracker> timeTrackerList;
  final TimeEnum timeEnum;
  final bool isHistory ;
  const TaskList({super.key, required this.timeTrackerList, required this.timeEnum, this.isHistory = false});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.timeTrackerList.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return TaskItem(
                time: widget.timeTrackerList[index],
              timeEnum: widget.timeEnum,
            isHistory: widget.isHistory,
          );
        }
    );
  }
}
