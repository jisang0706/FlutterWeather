import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logging/logging.dart';
import 'package:weather/core/dependency_injection.dart';
import 'package:weather/domain/usecase/calculate_sun_times_usecase.dart';
import 'package:weather/domain/usecase/get_address_usecase.dart';
import 'package:weather/domain/usecase/get_current_location_usecase.dart';
import 'package:weather/domain/usecase/get_region_by_code_usecase.dart';
import 'package:weather/domain/usecase/get_weather_usecase.dart';
import 'package:weather/presentation/blocs/base_event.dart';
import 'package:weather/presentation/blocs/base_bloc.dart';
import 'package:weather/presentation/pages/base_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await initializeDateFormatting("ko_KR");
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print(
        '${record.time}: [${record.level}] ${record.loggerName}: ${record.message}');
  });
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
        create: (_) => BaseBloc(
            getCurrentLocationUsecase:
                GetIt.instance<GetCurrentLocationUsecase>(),
            getAddressUsecase: GetIt.instance<GetAddressUsecase>(),
            getWeatherUsecase: GetIt.instance<GetWeatherUsecase>(),
            getRegionByCodeUsecase: GetIt.instance<GetRegionByCodeUsecase>(),
            calculateSunTimesUsecase:
                GetIt.instance<CalculateSunTimesUsecase>())
          ..add(FetchBase()))
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather',
        theme: ThemeData(fontFamily: 'Pretendard', brightness: Brightness.dark),
        darkTheme:
            ThemeData(fontFamily: 'Pretendard', brightness: Brightness.dark),
        themeMode: ThemeMode.system,
        home: const BaseScreen());
  }
}
