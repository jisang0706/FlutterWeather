import 'package:flutter/material.dart';
import 'package:weather/core/utils/date_time_helper.dart';

// 예보 기본 뷰
class ForecastItemView extends StatelessWidget {
  final double tmn;
  final double tmx;
  final DateTime dateTime;

  const ForecastItemView(
      {super.key,
      required this.tmn,
      required this.tmx,
      required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Text(DateTimeHelper.dateToWeekday(dateTime: dateTime),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
              Text(DateTimeHelper.dateToReadable(dateTime: dateTime),
                style: TextStyle(fontSize: 14),),
            ],
            ),
        const Spacer(),
        Text(
          "${tmn % 1 == 0 ? tmn.toInt() : tmn}°",
          style: TextStyle(color: Colors.blue),
        ),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 5),
          child: const Text("/"),),
        Text(
          "${tmx % 1 == 0 ? tmx.toInt() : tmx}°",
          style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ]),
    );
  }
}
