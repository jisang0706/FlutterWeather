import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/presentation/blocs/weather_bloc.dart';
import 'package:weather/presentation/blocs/weather_event.dart';
import 'package:weather/presentation/blocs/weather_state.dart';
import 'package:weather/presentation/widgets/weather_body.dart';
import 'package:weather/presentation/widgets/weather_header.dart';

// 메인 페이지 실질적인 화면
class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherBloc()..add(FetchWeather()),
      child: Scaffold(
        body: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
          if (state is WeatherLoading) {
            return const SafeArea(
                child: Center(child: CircularProgressIndicator()));
          } else if (state is WeatherLoaded) {
            return Container(
                color: state.backgroundColor,
                child: SafeArea(
                    child: Column(children: [
                  WeatherHeader(dateTime: state.dateTime, region: state.region),
                  Expanded(
                      child: Center(
                          child: WeatherBody(temperature: state.temperature)))
                ])));
          } else if (state is WeatherError) {
            return Center(child: Text(state.message));
          } else {
            return SafeArea(
                child: Center(
              child: Text("error"),
            ));
          }
        }),
      ),
    );
  }
}
