import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:time_tracker/app/dashboard/data/models/time_enum.dart';
import 'package:time_tracker/app/dashboard/data/models/time_tracker.dart';
import 'package:time_tracker/app/dashboard/presentation/widgets/time_row.dart';
import 'package:time_tracker/core/app_colors.dart';

class TaskItem extends StatelessWidget {

  final TimeTracker time;
  final TimeEnum timeEnum;
  final bool isHistory ;

  const TaskItem(
      {super.key,
      required this.time,
      required this.timeEnum, required this.isHistory });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        color: _getColor(time.title ?? 'N/A'),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Positioned(
            top: -10,
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SvgPicture.asset(
                  'images/icon-${time.title?.replaceAll(" ", '-').toLowerCase()}.svg',
                  height: 80,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 35,),
              Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      color: darkBlue, borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            time.title ?? 'N/A',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          const Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                          )
                        ],
                      ),
                      if (timeEnum == TimeEnum.daily) ...{
                        TimeRow(
                          timeRange: 'Yesterday',
                          time: time.timeframes?.daily,
                          isHistory: isHistory,
                        ),
                      } else if (timeEnum == TimeEnum.weekly) ...{
                        TimeRow(
                          timeRange: 'Last Week',
                          time: time.timeframes?.weekly,
                          isHistory: isHistory,
                        ),
                      } else ...{
                        TimeRow(
                          timeRange: 'Last Month',
                          time: time.timeframes?.monthly,
                          isHistory: isHistory,
                        ),
                      }
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Color _getColor(String title) {
    switch (title.toLowerCase()) {
      case 'work':
        return lightRedWork;
      case 'play':
        return softBluePlay;
      case 'study':
        return lightRedStudy;
      case 'exercise':
        return limeGreenExercise;
      case 'social':
        return violetSocial;
      case 'self care':
        return softOrangeSelfCare;
      default:
        return Colors.white;
    }
  }
}


