import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/utils/date_time_helper.dart';
import 'package:weather/presentation/blocs/base_bloc.dart';
import 'package:weather/presentation/blocs/base_state.dart';
import 'package:weather/presentation/blocs/location_state.dart';
import 'package:weather/presentation/blocs/weather_state.dart';
import 'package:weather/presentation/widgets/middle_forecast_items.dart';
import 'package:weather/presentation/widgets/short_forecast_item.dart';

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
          )),
      BlocBuilder<BaseBloc, BaseState>(
          buildWhen: (previous, current) => current is LocationState,
          builder: (context, state) {
            if (state is LocationLoaded) {
              return Column(
                children: [
                  ...List.generate(4, (index) {
                    return ShortForecastItem(
                        regionEntity: state.regionEntity,
                        dateTime: DateTimeHelper.adjustDay(
                            dateTime: DateTimeHelper.getCurrentDateTime(),
                            offsetDay: index));
                  }),
                  MiddleForecastItems(middleRegionId: state.middleRegionId),
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    ]);
  }
}
