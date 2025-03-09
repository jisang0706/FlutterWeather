import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/core/utils/date_time_helper.dart';
import 'package:weather/domain/usecase/get_middle_weather_usecase.dart';
import 'package:weather/presentation/blocs/middle_forecast_bloc.dart';
import 'package:weather/presentation/blocs/middle_forecast_event.dart';
import 'package:weather/presentation/blocs/middle_forecast_state.dart';
import 'package:weather/presentation/widgets/forecast_item_view.dart';

// 중기예보
class MiddleForecastItems extends StatelessWidget {
  final String middleRegionId;

  const MiddleForecastItems({super.key, required this.middleRegionId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MiddleForecastBloc(
            getMiddleWeatherUsecase: GetIt.instance<GetMiddleWeatherUsecase>())
          ..add(FetchMiddleForecast(
              dateTime: DateTimeHelper.getMiddleFixedTime(
                  DateTimeHelper.getCurrentDateTime()),
              middleRegionId: middleRegionId)),
        child: BlocBuilder<MiddleForecastBloc, MiddleForecastState>(
            builder: (context, state) {
          if (state is MiddleForecastLoaded) {
            DateTime dateTime = DateTimeHelper.adjustDay(
                dateTime: DateTimeHelper.getCurrentDateTime(), offsetDay: 3);
            return Column(children: [
              () {
                final forecast = (
                  state.middleForecastEntity.taMin4,
                  state.middleForecastEntity.taMax4
                );
                dateTime =
                    DateTimeHelper.adjustDay(dateTime: dateTime, offsetDay: 1);
                return ForecastItemView(
                    tmn: forecast.$1 ?? -1,
                    tmx: forecast.$2 ?? -2,
                    dateTime: dateTime);
              }(),
              ...List.generate(state.middleForecastEntity.taMin.length,
                  (index) {
                final forecast = (
                  state.middleForecastEntity.taMin[index],
                  state.middleForecastEntity.taMax[index]
                );
                dateTime =
                    DateTimeHelper.adjustDay(dateTime: dateTime, offsetDay: 1);
                return ForecastItemView(
                    tmn: forecast.$1, tmx: forecast.$2, dateTime: dateTime);
              }),
            ]);
          } else {
            return const CircularProgressIndicator();
          }
        }));
  }
}
