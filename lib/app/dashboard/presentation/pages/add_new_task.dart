import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracker/app/dashboard/data/bloc/time_tracker_cubit.dart';
import 'package:time_tracker/app/dashboard/data/models/time_frames.dart';
import 'package:time_tracker/app/dashboard/data/models/time_tracker.dart';
import 'package:time_tracker/app/dashboard/data/models/timeframes_time.dart';
import 'package:time_tracker/core/app_colors.dart';
import 'package:time_tracker/app/dashboard/presentation/widgets/custom_textfield.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  String selectedValue = "Work";
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  late TimeTrackerCubit timeTrackerCubit ;

  final TextEditingController _dailyPreviousTime = TextEditingController();
  final TextEditingController _dailyCurrentTime = TextEditingController();
  final TextEditingController _weeklyPreviousTime = TextEditingController();
  final TextEditingController _weeklyCurrentTime = TextEditingController();
  final TextEditingController _monthlyPreviousTime = TextEditingController();
  final TextEditingController _monthlyCurrentTime = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Work", child: Text("Work")),
      const DropdownMenuItem(value: "Play", child: Text("Play")),
      const DropdownMenuItem(value: "Social", child: Text("Social")),
      const DropdownMenuItem(value: "Study", child: Text("Study")),
      const DropdownMenuItem(value: "Exercise", child: Text("Exercise")),
      const DropdownMenuItem(value: "Self Care", child: Text("Self Care")),
    ];
    return menuItems;
  }

  @override
  void initState() {
    if(mounted){
      timeTrackerCubit = context.read<TimeTrackerCubit>();
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text(
          'Add New Task',
          style: TextStyle(color: violetDashboard),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        iconTheme: const IconThemeData(color: violetDashboard),
      ),
      body: BlocListener<TimeTrackerCubit, TimeTrackerState>(
        bloc: timeTrackerCubit,
        listenWhen: (previous, current) {
          return current is AddTaskError || current is AddTaskSuccess || current is AddTaskLoading;
        },
        listener: (context, state) {
          if (state is AddTaskError) {
            isLoading.value = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is AddTaskLoading) {
            isLoading.value = true;
          }
          if (state is AddTaskSuccess) {
            isLoading.value = false;
            clearText();
            _showMyDialog();
            timeTrackerCubit.fetchTasks();
          }
        },
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
            ),
            children: [
              const Text(
                'Task Name',
                style: TextStyle(fontSize: 15, color: violetDashboard),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 1.0,
                        style: BorderStyle.solid,
                        color: violetDashboard),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
                child: DropdownButton(
                    isExpanded: true,
                    underline: Container(
                      height: 0,
                    ),
                    style: const TextStyle(
                        color: violetDashboard,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                    borderRadius: BorderRadius.circular(15),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: violetDashboard,
                    ),
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                    items: dropdownItems),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 1.0,
                        style: BorderStyle.solid,
                        color: violetDashboard),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    trailing: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: violetDashboard,
                    ),
                    initiallyExpanded: true,
                    collapsedIconColor: violetDashboard,
                    tilePadding: EdgeInsets.zero,
                    title: const Text(
                      'Daily',
                      style: TextStyle(fontSize: 15, color: violetDashboard),
                    ),
                    children: [
                      CustomTextField(
                        textEditingController: _dailyPreviousTime,
                        hinText: "Previous Time",
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextField(
                        textEditingController: _dailyCurrentTime,
                        hinText: "Current Time",
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 1.0,
                        style: BorderStyle.solid,
                        color: violetDashboard),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    trailing: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: violetDashboard,
                    ),
                    initiallyExpanded: true,
                    collapsedIconColor: violetDashboard,
                    tilePadding: EdgeInsets.zero,
                    title: const Text(
                      'Weekly',
                      style: TextStyle(fontSize: 15, color: violetDashboard),
                    ),
                    children: [
                      CustomTextField(
                        textEditingController: _weeklyPreviousTime,
                        hinText: "Previous Time",
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextField(
                        textEditingController: _weeklyCurrentTime,
                        hinText: "Current Time",
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 1.0,
                        style: BorderStyle.solid,
                        color: violetDashboard),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    trailing: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: violetDashboard,
                    ),
                    collapsedIconColor: violetDashboard,
                    initiallyExpanded: true,
                    tilePadding: EdgeInsets.zero,
                    title: const Text(
                      'Monthly',
                      style: TextStyle(fontSize: 15, color: violetDashboard),
                    ),
                    children: [
                      CustomTextField(
                        textEditingController: _monthlyPreviousTime,
                        hinText:  "Previous Time",
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextField(
                        textEditingController: _monthlyCurrentTime,
                        hinText: "Current Time",
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ValueListenableBuilder(
                valueListenable: isLoading,
                builder: (BuildContext context, bool value, Widget? child) {
                  return MaterialButton(
                    height: 50,
                    elevation: 0,
                    onPressed: () {
                      addTask(context);
                    },
                    color: violetDashboard,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: !value
                        ? const Text("Add Task",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w500))
                        : const CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'New Task',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text('You have successfully added a new task',
              style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              child:
                  const Text('Dismiss', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void clearText() {
    _dailyPreviousTime.clear();
    _dailyCurrentTime.clear();
    _weeklyPreviousTime.clear();
    _weeklyCurrentTime.clear();
    _monthlyPreviousTime.clear();
    _monthlyCurrentTime.clear();
  }

  void addTask(BuildContext context) {
    //validate that all fields are filled
    if(_formKey.currentState!.validate()){
      timeTrackerCubit.addTask(
          timeTracker: TimeTracker(
            title: selectedValue,
            timeframes: Timeframes(
              daily: Time(
                  previous: int.tryParse(_dailyPreviousTime.text),
                  current: int.tryParse(_dailyCurrentTime.text)),
              weekly: Time(
                  previous: int.tryParse(_weeklyPreviousTime.text),
                  current: int.tryParse(_weeklyCurrentTime.text)),
              monthly: Time(
                  previous: int.tryParse(_monthlyPreviousTime.text),
                  current: int.tryParse(_monthlyCurrentTime.text)),
            ),
          ));
    }


  }
}
