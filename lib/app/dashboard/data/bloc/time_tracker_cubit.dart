import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:time_tracker/app/dashboard/data/data_sources/hive_service.dart';
import 'package:time_tracker/app/dashboard/data/models/time_frames.dart';
import 'package:time_tracker/app/dashboard/data/models/time_tracker.dart';
import 'package:time_tracker/app/dashboard/data/models/timeframes_time.dart';
import 'package:time_tracker/app/dashboard/data/repositories/time_tracker_repository.dart';

part 'time_tracker_state.dart';

class TimeTrackerCubit extends Cubit<TimeTrackerState> {

  TimeTrackerRepository timeTrackerRepository ;
  final HiveService hiveService ;


  TimeTrackerCubit({required this.timeTrackerRepository,required this.hiveService}) :  super(TimeTrackerInitial());

  Future<void> fetchTasks() async {
    try {
      emit(FetchTasksLoading());
      List<TimeTracker> allTasks = await hiveService.getTasks();

      if (allTasks.isNotEmpty) {

        emit(FetchTasksSuccess(timeTrackerList: allTasks));

      } else {
        final response = await timeTrackerRepository.fetchTasks();

        response.fold((l) => emit(FetchTasksError(error: l)), (r) {
          hiveService.addTasks(timeTracker:r);
          emit(FetchTasksSuccess(timeTrackerList: r));
        });
      }
    } catch (e) {
      emit(FetchTasksError(error: e.toString()));
    }
  }

  Future<void> addTask({required TimeTracker timeTracker}) async {
    try {
      emit(AddTaskLoading());
      hiveService.addTask(timeTracker: timeTracker);
      emit(AddTaskSuccess());
    } catch (e) {
      emit(AddTaskError(error: e.toString()));
    }
  }


  void fetchTaskHistory()  {
    try {
      emit(FetchTaskHistoryLoading());

      List<TimeTracker> allTasks =  _generateFakeData();

      emit(FetchTaskHistorySuccess(timeTrackerList: allTasks));

    } catch (e) {
      emit(FetchTaskHistoryError(error: e.toString()));
    }
  }

  List<TimeTracker> _generateFakeData() {
  List<String> titles = ['Work', 'Play', 'Exercise', 'Social', 'Self Care', 'Study' ];
    final random = Random();

    return List<TimeTracker>.generate(10, (index) {
      return TimeTracker(
        title: titles[random.nextInt(titles.length)],
        timeframes: Timeframes(
          daily: Time(current: random.nextInt(10), previous: random.nextInt(10)),
          weekly: Time(current: random.nextInt(70), previous: random.nextInt(70)),
          monthly: Time(current: random.nextInt(300), previous: random.nextInt(300)),
        ),
      );
    });
  }
}
