import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/presentation/blocs/base_bloc.dart';
import 'package:weather/presentation/blocs/base_state.dart';
import 'package:weather/presentation/blocs/location_state.dart';
import 'package:weather/presentation/blocs/weather_state.dart';

// 메인 페이지 header
class BaseHeader extends StatelessWidget {
  const BaseHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<BaseBloc, BaseState>(
              buildWhen: (previous, current) => current is LocationState,
              builder: (context, state) {
                if (state is LocationLoaded) {
                  return _text(state.region);
                }
                return _text("");
              }),
          BlocBuilder<BaseBloc, BaseState>(
              buildWhen: (previous, current) => current is WeatherState,
              builder: (context, state) {
                if (state is WeatherLoaded) {
                  return _text(state.dateTime);
                }
                return _text("");
              })
        ],
      ),
    );
  }

  Text _text(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
      textAlign: TextAlign.right,
    );
  }
}
