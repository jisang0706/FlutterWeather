import 'package:flutter/material.dart';

// 메인 페이지 body
class WeatherBody extends StatelessWidget {
  final String temperature;

  const WeatherBody({super.key, required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Text(temperature,
        style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold));
  }
}
