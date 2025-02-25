import 'package:flutter/material.dart';

// 메인 페이지 header
class WeatherHeader extends StatelessWidget {
  final String dateTime;
  final String region;

  const WeatherHeader(
      {super.key, required this.dateTime, required this.region});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(region,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w100)),
          Text(
            dateTime,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
            textAlign: TextAlign.right,
          )
        ],
      ),
    );
  }
}
