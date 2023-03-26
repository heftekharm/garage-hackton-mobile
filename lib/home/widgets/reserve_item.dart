import 'package:flutter/material.dart';
import 'package:garage/home/home_bloc.dart';

enum ReserverStatus { reservable, reserved, full, holiday }

const Map<ReserverStatus, String> reserveStatusTextMap = {
  ReserverStatus.reservable: "رزرو کن",
  ReserverStatus.reserved: "رزرو کردی",
  ReserverStatus.full: "پر شده",
  ReserverStatus.holiday: "تعطیل",
};

class ReserveItemWidget extends StatelessWidget {
  final ReserverStatus reserverStatus;
  final String cost;
  final String weekDay;
  final String date;
  final VoidCallback onReserve;

  const ReserveItemWidget(
    this.weekDay,
    this.date,
    this.reserverStatus,
    this.cost,
    this.onReserve, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Expanded(
                child:
                    Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [Text("شنبه"), Text("17 بهمن")])),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(cost),
            ),
            FilledButton(
              onPressed: reserverStatus == ReserverStatus.reservable ? onReserve : null,
              child: Text(reserveStatusTextMap[reserverStatus]!),
            )
          ],
        ),
      ),
    );
  }

  static ReserveItemWidget fromDayState(DayState dayState, VoidCallback onReserve) =>
      ReserveItemWidget(dayState.weekDay, dayState.date, dayState.reserverStatus, dayState.cost.toString(), onReserve);
}
