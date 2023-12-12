import 'package:flutter/material.dart';
import 'package:time_tracker/app/dashboard/presentation/pages/add_new_task.dart';
import 'package:time_tracker/core/app_colors.dart';
import 'package:time_tracker/app/dashboard/presentation/pages/task_history.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          const SizedBox(height: 80,),
          ListTile(
            title: const Text('Add New Task',style: TextStyle(color: violetDashboard),),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewTask()));
            },
          ),
          ListTile(
            title: const Text('Trends',style: TextStyle(color: violetDashboard)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TaskHistory()));
            },
          ),
        ],
      ),
    );
  }
}
