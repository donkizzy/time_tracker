import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracker/core/app_colors.dart';
import 'package:time_tracker/app/dashboard/data/bloc/time_tracker_cubit.dart';
import 'package:time_tracker/app/dashboard/data/models/time_enum.dart';
import 'package:time_tracker/app/dashboard/presentation/widgets/task_list.dart';
import 'package:time_tracker/app/dashboard/presentation/widgets/task_loader.dart';

class TaskHistory extends StatefulWidget {
  const TaskHistory({super.key});

  @override
  State<TaskHistory> createState() => _TaskHistoryState();
}

class _TaskHistoryState extends State<TaskHistory>  with SingleTickerProviderStateMixin {

  late TabController _tabController;
  late TimeTrackerCubit timeTrackerCubit;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    if(mounted){
      timeTrackerCubit = context.read<TimeTrackerCubit>();
      timeTrackerCubit.fetchTaskHistory();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: theme.colorScheme.background,
              elevation: 0.0,
              iconTheme: const IconThemeData(color: violetDashboard),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                decoration: BoxDecoration(
                  color: darkBlue,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 30.0),
                      decoration: BoxDecoration(
                        color: violetDashboard,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child:  Row(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(35),
                                child: Image.network('https://avatars.githubusercontent.com/u/19484515?v=4')),
                          ),
                          const SizedBox(width: 20.0),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Report for',
                                  style: TextStyle(
                                    color: paleBlue,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Jeremy Robson',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Theme(
                      data: theme.copyWith(
                        colorScheme: theme.colorScheme.copyWith(
                          surfaceVariant: Colors.transparent,
                        ),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        indicatorColor: Colors.transparent,
                        labelColor: Colors.white,
                        unselectedLabelColor: paleBlue.withOpacity(0.5),
                        unselectedLabelStyle:
                        const TextStyle(fontSize: 16, color: paleBlue,fontWeight: FontWeight.w500),
                        labelStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                        //indicatorColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        tabs: const [
                          Tab(text: 'Daily'),
                          Tab(text: 'Weekly'),
                          Tab(text: 'Monthly'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ];
        },
        body: BlocBuilder<TimeTrackerCubit, TimeTrackerState>(
          buildWhen: (previous, current) {
            return current is FetchTaskHistoryLoading ||
                current is FetchTaskHistorySuccess ||
                current is FetchTaskHistoryError;
          },
          bloc: timeTrackerCubit,
          builder: (context, state) {
            if(state is FetchTaskHistoryLoading){
              return const TaskLoader();
            }
            if(state is FetchTaskHistoryError){
              return Center(child: Text(state.error));
            }
            if(state is FetchTaskHistorySuccess){
              return TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  TaskList(
                    timeEnum: TimeEnum.daily,
                    timeTrackerList: state.timeTrackerList,
                    isHistory: true,
                  ),
                  TaskList(
                    timeEnum: TimeEnum.weekly,
                    timeTrackerList: state.timeTrackerList,
                    isHistory: true,
                  ),
                  TaskList(
                    timeEnum: TimeEnum.monthly,
                    timeTrackerList: state.timeTrackerList,
                    isHistory: true,
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
