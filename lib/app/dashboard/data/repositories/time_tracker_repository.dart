import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:time_tracker/core/network/network_provider.dart';
import 'package:time_tracker/app/dashboard/data/models/time_tracker.dart';

class TimeTrackerRepository {
  final NetworkProvider networkProvider;

  TimeTrackerRepository({required this.networkProvider});


  Future<Either<String, List<TimeTracker>>> fetchTasks() async {
    try {
      var response = await networkProvider.call(
          path: 'https://wookie.codesubmit.io/time-tracking',
          method: RequestMethod.get);
      if (response?.statusCode == 200) {
        List<TimeTracker> timeTrackerList = List<TimeTracker>.from(
            response?.data.map((x) => TimeTracker.fromJson(x)));

        return Right(timeTrackerList);
      } else {
        return Left(response?.data['message'].toString() ?? 'Error');
      }
    } on DioException catch (e) {
      return Left(e.toString());
    }
  }
}
