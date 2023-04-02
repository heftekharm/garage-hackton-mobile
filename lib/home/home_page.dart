import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/home/home_bloc.dart';
import 'package:garage/home/widgets/reserve_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) => current != previous && current is HomePageLoadedState,
              builder: (context, state) {
                state = state as HomePageLoadedState;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(state.user.name, style: Theme.of(context).textTheme.titleMedium),
                    Text('بدهی : ${state.user.debt}', style: Theme.of(context).textTheme.titleSmall),
                  ],
                );
              },
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.info_outline_rounded,
                    color: Theme.of(context).colorScheme.secondary,
                  )),
              Transform.scale(
                scaleX: -1,
                child: IconButton(
                    onPressed: () {
                      context.read<HomeCubit>().exit();
                    },
                    icon: Icon(
                      Icons.exit_to_app_rounded,
                      color: Theme.of(context).colorScheme.secondary,
                    )),
              ),
            ],
            bottom: const TabBar(indicatorPadding: EdgeInsets.only(top: 45), tabs: [Tab(text: "هفته جاری"), Tab(text: "هفته آتی")]),
          ),
          body: BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (previous, current) => current != previous && current is HomePageLoadedState,
            builder: (context, state) {
              state = state as HomePageLoadedState;
              return TabBarView(children: [getWeekTab(context, state.currentWeek), getWeekTab(context, state.nextWeek)]);
            },
          ),
        ),
      ),
    );
  }

  Widget getWeekTab(BuildContext context, List<DayModel> weekState) {
    return Column(
      children: [
        ...weekState.map(
          (e) => ReserveItemWidget.fromDayState(
            e,
            () {
              context.read<HomeCubit>().reserve(e.date, e.cost);
            },
          ),
        ),
      ],
    );
  }
}
