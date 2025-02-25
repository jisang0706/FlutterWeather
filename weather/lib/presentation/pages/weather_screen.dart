import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/presentation/blocs/weather_bloc.dart';
import 'package:weather/presentation/blocs/weather_event.dart';
import 'package:weather/presentation/blocs/weather_state.dart';
import 'package:weather/presentation/widgets/weather_body.dart';
import 'package:weather/presentation/widgets/weather_header.dart';

// 메인 페이지 실질적인 화면
class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherBloc()..add(FetchWeather()),
      child: Scaffold(
        body: SafeArea(child:
            BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoaded) {
            return Column(children: [
              WeatherHeader(dateTime: state.dateTime, region: state.region),
              Expanded(
                  child: Center(
                      child: WeatherBody(temperature: state.temperature)))
            ]);
          } else if (state is WeatherError) {
            return Center(child: Text(state.message));
          } else {
            return Center(
              child: Text("error"),
            );
          }
        })),
      ),
    );
  }
}
