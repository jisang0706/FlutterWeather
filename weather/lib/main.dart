import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather/domain/usecase/get_weather_usecase.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather',
        theme: ThemeData(),
        home: const MyHomePage(title: 'Weather'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String weatherInfo = "날씨 정보를 불러오는 중";
  final getWeatherUseCase = GetWeatherUsecase(Dio());

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("성북구 날씨")),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16.8),
        child: Text(weatherInfo,
            textAlign: TextAlign.center, style: const TextStyle(fontSize: 18)),
      )),
    );
  }

  // 날씨 정보 weatherInfo에 넣고 UI업데이트
  Future<void> fetchWeather() async {
    try {
      final t1hValue = await getWeatherUseCase.execute();

      setState(() {
        weatherInfo = t1hValue;
      });
    } catch (e) {
      setState(() {
        weatherInfo = "날씨 정보를 불러올 수 없습니다.\n$e";
      });
    }
  }
}
