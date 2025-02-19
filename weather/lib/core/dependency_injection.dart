import 'package:get_it/get_it.dart';
import 'package:weather/core/network/dio_client.dart';
import 'package:weather/data/datasources/address_remote_data_source.dart';
import 'package:weather/data/repository/address_repository_impl.dart';
import 'package:weather/domain/repositories/address_repository.dart';
import 'package:weather/domain/usecase/get_address_usecase.dart';

// DI (의존성 주입)
final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<DioClient>(() => DioClient());

  getIt.registerLazySingleton<AddressRemoteDataSource>(
      () => AddressRemoteDataSource(dio: getIt<DioClient>().kakaoDio));

  getIt.registerLazySingleton<AddressRepository>(() => AddressRepositoryImpl(
      remoteDataSource: getIt<AddressRemoteDataSource>()));

  getIt.registerLazySingleton<GetAddressUsecase>(
      () => GetAddressUsecase(getIt<AddressRepository>()));
}
