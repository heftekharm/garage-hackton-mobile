import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('اکبر بی قاعده', style: Theme.of(context).textTheme.titleMedium),
              Text('بدهی : 123', style: Theme.of(context).textTheme.titleSmall),
            ],
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
                  onPressed: () {},
                  icon: Icon(
                    Icons.exit_to_app_rounded,
                    color: Theme.of(context).colorScheme.secondary,
                  )),
            ),
          ],
          bottom: TabBar(indicatorPadding: EdgeInsets.only(top: 45), tabs: [Tab(text: "هفته جاری"), Tab(text: "هفته آتی")]),
        ),
        body: TabBarView(children: [currentWeekTab(), nextWeekTab()]),
      ),
    );
  }

  Widget currentWeekTab() {
    return Column(
      children: [
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                        mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [Text("شنبه"), Text("17 بهمن")])),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text("50 تومان"),
                ),
                FilledButton(onPressed: () {}, child: Text("رزرو کن"))
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget nextWeekTab() {
    return Icon(Icons.access_alarm_rounded);
  }
}
