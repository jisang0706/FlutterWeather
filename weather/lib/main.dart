import 'package:flutter/material.dart';
import 'package:weather/domain/entities/address_entity.dart';
import 'package:weather/domain/usecase/get_address_usecase.dart';
import 'package:weather/domain/usecase/get_region_by_name_usecase.dart';
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
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
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
  String appBarText = "날씨";
  final getWeatherUseCase = GetWeatherUsecase();
  final getAddressUsecase = GetAddressUsecase();
  final getRegionByNameUsecase = GetRegionByNameUsecase();

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appBarText)),
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
    // 역지오코딩 호출
    final address = await getAddressUsecase.execute();

    setState(() {
      appBarText = address.fold(
          (failure) => "서울특별시 날씨", (address) => "${address.region3Depth} 날씨");
    });

    final regionEntity = await getRegionByNameUsecase
        .execute(address.getOrElse(() => AddressEntity.emptyEntity()));

    final weather = await getWeatherUseCase.execute(regionEntity);

    setState(() {
      weatherInfo = weather.fold((failure) => "error: ${failure.message}",
          (result) => "${result.t1h} 도");
    });
  }
}
