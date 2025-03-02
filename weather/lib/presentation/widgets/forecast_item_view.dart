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
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(DateTimeHelper.dateToReadable(dateTime: dateTime)),
      Text("$tmn"),
      Text("/"),
      Text("$tmx")
    ]);
  }
}
