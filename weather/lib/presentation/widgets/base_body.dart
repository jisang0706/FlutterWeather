import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/presentation/blocs/base_bloc.dart';
import 'package:weather/presentation/blocs/base_state.dart';
import 'package:weather/presentation/blocs/weather_state.dart';

// 메인 페이지 body
class BaseBody extends StatelessWidget {
  final double firstItemHeight;
  const BaseBody({super.key, required this.firstItemHeight});

  @override
  Widget build(BuildContext context) {
    return ListView(physics: AlwaysScrollableScrollPhysics(), children: [
      SizedBox(
          height: firstItemHeight,
          child: Center(
            child: BlocBuilder<BaseBloc, BaseState>(
                buildWhen: (previous, current) => current is WeatherState,
                builder: (context, state) {
                  if (state is WeatherLoaded) {
                    return Text(state.temperature,
                        style: const TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold));
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ))
    ]);
  }
}
