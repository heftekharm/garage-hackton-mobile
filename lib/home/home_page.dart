import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage/home/home_bloc.dart';
import 'package:garage/home/widgets/reserve_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(state.userState.name, style: Theme.of(context).textTheme.titleMedium),
                    Text('بدهی : ${state.userState.debt}', style: Theme.of(context).textTheme.titleSmall),
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
                      context.read<HomeBloc>().add(ExitHomeEvent());
                    },
                    icon: Icon(
                      Icons.exit_to_app_rounded,
                      color: Theme.of(context).colorScheme.secondary,
                    )),
              ),
            ],
            bottom: TabBar(indicatorPadding: const EdgeInsets.only(top: 45), tabs: [Tab(text: "هفته جاری"), Tab(text: "هفته آتی")]),
          ),
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return TabBarView(children: [getWeekTab(context, state.currentWeekState), getWeekTab(context, state.nextWeekState)]);
            },
          ),
        ),
      ),
    );
  }

  Widget getWeekTab(BuildContext context, WeekState weekState) {
    return Column(
      children: [
        ...weekState.days.map(
          (e) => ReserveItemWidget.fromDayState(
            e,
            () {
              context.read<HomeBloc>().add(ReserveEvent(e.date, e.cost));
            },
          ),
        ),
      ],
    );
  }
}
