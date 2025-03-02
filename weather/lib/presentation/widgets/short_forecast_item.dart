import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/core/utils/date_time_helper.dart';
import 'package:weather/domain/entities/region_entity.dart';
import 'package:weather/domain/usecase/get_weather_usecase.dart';
import 'package:weather/presentation/blocs/short_forecast_bloc.dart';
import 'package:weather/presentation/blocs/short_forecast_event.dart';
import 'package:weather/presentation/blocs/short_forecast_state.dart';
import 'package:weather/presentation/widgets/forecast_item_view.dart';

// 향후 3일 예보
class ShortForecastItem extends StatelessWidget {
  final RegionEntity regionEntity;
  final DateTime dateTime;

  const ShortForecastItem(
      {required this.regionEntity, required this.dateTime, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShortForecastBloc(
          getWeatherUsecase: GetIt.instance<GetWeatherUsecase>())
        ..add(FetchShortForecast(
            regionEntity: regionEntity,
            pageNo: DateTimeHelper.calculateDayDiffrence(
                    from: DateTimeHelper.getCurrentDateTime(), to: dateTime) +
                1)),
      child: BlocBuilder<ShortForecastBloc, ShortForecastState>(
          builder: (context, state) {
        if (state is ShortForecastLoaded) {
          return ForecastItemView(
              tmn: state.shortForecastEntity.tmn,
              tmx: state.shortForecastEntity.tmx,
              dateTime: state.shortForecastEntity.dateTime);
        } else if (state is ShortForecastError) {
          return Text("error: ${state.message}");
        } else {
          return const CircularProgressIndicator();
        }
      }),
    );
  }
}
