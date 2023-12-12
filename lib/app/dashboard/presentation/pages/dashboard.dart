import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracker/app/dashboard/data/bloc/time_tracker_cubit.dart';
import 'package:time_tracker/app/dashboard/data/models/time_enum.dart';
import 'package:time_tracker/app/dashboard/presentation/widgets/app_drawer.dart';
import 'package:time_tracker/app/dashboard/presentation/widgets/task_list.dart';
import 'package:time_tracker/app/dashboard/presentation/widgets/task_loader.dart';
import 'package:time_tracker/core/app_colors.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TimeTrackerCubit timeTrackerCubit;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
   if(mounted){
     timeTrackerCubit = context.read<TimeTrackerCubit>();
     timeTrackerCubit.fetchTasks();
   }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      drawer: const AppDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: theme.colorScheme.background,
              elevation: 0.0,
              iconTheme: const IconThemeData(color: violetDashboard),
              actions: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    AdaptiveTheme.of(context).toggleThemeMode();
                  },
                  child: const Text(
                    'Toggle Theme',
                    style: TextStyle(color: violetDashboard, ),
                  ),
                ),
                const SizedBox(width: 20,)
              ],
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
           return current is FetchTasksLoading ||
                current is FetchTasksError ||
                current is FetchTasksSuccess;
          },
          bloc: timeTrackerCubit,
          builder: (context, state) {

            if(state is FetchTasksLoading){
              return const TaskLoader();
            }
            if(state is FetchTasksError){
              return Center(child: Text(state.error));
            }
            if(state is FetchTasksSuccess){
              return TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  TaskList(
                    timeEnum: TimeEnum.daily,
                    timeTrackerList: state.timeTrackerList,
                  ),
                  TaskList(
                    timeEnum: TimeEnum.weekly,
                    timeTrackerList: state.timeTrackerList,
                  ),
                  TaskList(
                    timeEnum: TimeEnum.monthly,
                    timeTrackerList: state.timeTrackerList,
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
