import 'package:flutter/material.dart';
import 'package:time_tracker/app/dashboard/data/models/timeframes_time.dart';
import 'package:time_tracker/core/app_colors.dart';

class TimeRow extends StatelessWidget {
  final Time? time;
  final String timeRange ;
  final bool isHistory ;
  const TimeRow({
    super.key,
    required this.time,
    required this.timeRange, required this.isHistory,
  });

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${time?.current ?? 0}hrs',
          style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w400),
        ),
        if(!isHistory) ...{
          Text('$timeRange - ${time?.previous ?? 0}hrs',
              style: const TextStyle(
                  color: paleBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.w400))
        } else ... {
          Text('$timeRange + ${time?.previous ?? 0}hrs',
              style: const TextStyle(
                  color: paleBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.w400))
        }

      ],
    );
  }
}