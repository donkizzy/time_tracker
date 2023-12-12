import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:time_tracker/core/app_colors.dart';

class TaskLoader extends StatefulWidget {
  const TaskLoader({super.key});

  @override
  State<TaskLoader> createState() => _TaskLoaderState();
}

class _TaskLoaderState extends State<TaskLoader> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 10,
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.2),
          highlightColor: veryDarkBlue.withOpacity(0.1),
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: violetSocial),
          ),
        );
      }, separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 20,);
    },
    );
  }
}
