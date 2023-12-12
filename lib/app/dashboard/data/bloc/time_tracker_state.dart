part of 'time_tracker_cubit.dart';

abstract class TimeTrackerState extends Equatable {
  const TimeTrackerState();
}

class TimeTrackerInitial extends TimeTrackerState {
  @override
  List<Object> get props => [];
}

class FetchTasksLoading extends TimeTrackerState {
  @override
  List<Object> get props => [];
}

class FetchTasksSuccess extends TimeTrackerState {
  final List<TimeTracker> timeTrackerList;

  const FetchTasksSuccess({required this.timeTrackerList});

  @override
  List<Object> get props => [];
}

class FetchTasksError extends TimeTrackerState {
  final String error ;

  const FetchTasksError({required this.error});
  @override
  List<Object> get props => [];
}

class AddTaskLoading extends TimeTrackerState {
  @override
  List<Object> get props => [];
}

class AddTaskSuccess extends TimeTrackerState {
  @override
  List<Object> get props => [];
}

class AddTaskError extends TimeTrackerState {

  final String error ;

  const AddTaskError({required this.error});

  @override
  List<Object> get props => [];
}

class FetchTaskHistoryLoading extends TimeTrackerState {
  @override
  List<Object> get props => [];
}

class FetchTaskHistorySuccess extends TimeTrackerState {
  final List<TimeTracker> timeTrackerList;

  const FetchTaskHistorySuccess({required this.timeTrackerList});

  @override
  List<Object> get props => [];
}

class FetchTaskHistoryError extends TimeTrackerState {
  final String error ;

  const FetchTaskHistoryError({required this.error});
  @override
  List<Object> get props => [];
}


