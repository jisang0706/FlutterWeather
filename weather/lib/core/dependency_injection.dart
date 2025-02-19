import 'package:get_it/get_it.dart';
import 'package:weather/core/network/dio_client.dart';
import 'package:weather/data/datasources/address_remote_data_source.dart';
import 'package:weather/data/datasources/location_data_source.dart';
import 'package:weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather/data/repository/address_repository_impl.dart';
import 'package:weather/data/repository/location_repository_impl.dart';
import 'package:weather/data/repository/weather_repository_impl.dart';
import 'package:weather/domain/repositories/address_repository.dart';
import 'package:weather/domain/repositories/location_repository.dart';
import 'package:weather/domain/repositories/weather_repository.dart';
import 'package:weather/domain/usecase/get_address_usecase.dart';
import 'package:weather/domain/usecase/get_current_location_usecase.dart';
import 'package:weather/domain/usecase/get_weather_usecase.dart';

// DI (의존성 주입)
final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<DioClient>(() => DioClient());

  getIt.registerLazySingleton<AddressRemoteDataSource>(
      () => AddressRemoteDataSource(dio: getIt<DioClient>().kakaoDio));
  getIt.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSource(dio: getIt<DioClient>().weatherDio));
  getIt.registerLazySingleton<LocationDataSource>(() => LocationDataSource());

  getIt.registerLazySingleton<AddressRepository>(() => AddressRepositoryImpl(
      addressRemoteDataSource: getIt<AddressRemoteDataSource>()));
  getIt.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(
      weatherRemoteDataSource: getIt<WeatherRemoteDataSource>()));
  getIt.registerLazySingleton<LocationRepository>(() =>
      LocationRepositoryImpl(locationDataSource: getIt<LocationDataSource>()));

  getIt.registerLazySingleton<GetAddressUsecase>(
      () => GetAddressUsecase(addressRepository: getIt<AddressRepository>()));
  getIt.registerLazySingleton<GetWeatherUsecase>(
      () => GetWeatherUsecase(weatherRepository: getIt<WeatherRepository>()));
  getIt.registerLazySingleton<GetCurrentLocationUsecase>(() =>
      GetCurrentLocationUsecase(
          locationRepository: getIt<LocationRepository>()));
}
