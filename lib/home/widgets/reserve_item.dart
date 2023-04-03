import 'package:flutter/material.dart';
import 'package:garage/home/home_bloc.dart';
import 'package:garage/login/login_bloc.dart';
import 'package:garage/login/widgets/submit_button.dart';

enum ReserverStatus { holiday, passed, reservable, biddableFull, notBiddableFull, reserved }

const Map<ReserverStatus, String> reserveStatusTextMap = {
  ReserverStatus.holiday: "تعطیل",
  ReserverStatus.passed: "گذشته",
  ReserverStatus.reservable: "رزرو کن",
  ReserverStatus.biddableFull: "(قابل رزرو) پر شده",
  ReserverStatus.notBiddableFull: "پر شده",
  ReserverStatus.reserved: "رزرو کردی",
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
    var shouldButtonBeEnabled = reserverStatus == ReserverStatus.reservable || reserverStatus == ReserverStatus.biddableFull;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: reserverStatus == ReserverStatus.reserved ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.9),
              blurRadius: 2.0, // soften the shadow
              spreadRadius: 0.5, //extend the shadow
            )
          ],
        ),
        child: Row(
          children: [
            Expanded(
                child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [Text(weekDay), Text(date)])),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text("$cost تومان"),
            ),
            FilledButton(
              style: ButtonStyle(backgroundColor: shouldButtonBeEnabled ? null : const MaterialStatePropertyAll(Colors.transparent)),
              onPressed: shouldButtonBeEnabled
                  ? () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                                titleTextStyle: Theme.of(context).textTheme.titleLarge,
                                title: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [Text("$weekDay ($date)    "), Text("$cost تومان")],
                                ),
                                content: const Text("خداوکیلی مطمینی؟"),
                                titlePadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                                actions: [
                                  SubmitButton(
                                    "ها کاکو",
                                    SubmitStatus.ready,
                                    () {
                                      onReserve();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("نچ"))
                                ],
                              ));
                    }
                  : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(reserveStatusTextMap[reserverStatus]!),
              ),
            )
          ],
        ),
      ),
    );
  }

  static ReserveItemWidget fromDayState(DayModel dayState, VoidCallback onReserve) =>
      ReserveItemWidget(dayState.weekDay, dayState.date, dayState.reserverStatus, dayState.cost.toString(), onReserve);
}
