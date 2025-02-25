import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather/core/dependency_injection.dart';
import 'package:weather/presentation/pages/weather_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await initializeDateFormatting("ko_KR");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather',
        theme:
            ThemeData(fontFamily: 'Pretendard', brightness: Brightness.light),
        darkTheme:
            ThemeData(fontFamily: 'Pretendard', brightness: Brightness.dark),
        themeMode: ThemeMode.system,
        home: const WeatherScreen());
  }
}
