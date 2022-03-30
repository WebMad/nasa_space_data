import 'package:get_it/get_it.dart';
import 'package:nasa_space_data/src/data/data_sources/nasa_remote_data_source.dart';
import 'package:nasa_space_data/src/data/repositories/photo_repository_impl.dart';
import 'package:nasa_space_data/src/data/repositories/rover_repository_impl.dart';
import 'package:nasa_space_data/src/domain/repositories/photo_repository.dart';
import 'package:nasa_space_data/src/domain/repositories/rover_repository.dart';
import 'package:nasa_space_data/src/domain/use_cases/photo_list_use_case.dart';
import 'package:nasa_space_data/src/domain/use_cases/rover_list_use_case.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

init() {
  sl.registerLazySingleton<PhotoRepository>(() => PhotoRepositoryImpl(sl()));
  sl.registerLazySingleton<RoverRepository>(() => RoverRepositoryImpl(sl()));

  sl.registerLazySingleton<NasaRemoteDataSource>(
      () => NasaRemoteDataSourceImpl(sl()));

  sl.registerLazySingleton<PhotoListUseCase>(() => PhotoListUseCase(sl()));
  sl.registerLazySingleton<RoverListUseCase>(() => RoverListUseCase(sl()));

  sl.registerLazySingleton(() => http.Client());
}
