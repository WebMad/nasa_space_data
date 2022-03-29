import 'package:nasa_space_data/src/data/data_sources/nasa_remote_data_source.dart';
import 'package:nasa_space_data/src/domain/entities/rover_entity.dart';
import 'package:nasa_space_data/src/domain/repositories/rover_repository.dart';

class RoverRepositoryImpl extends RoverRepository {
  final NasaRemoteDataSource _remoteDataSource;

  RoverRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<RoverEntity>> roverList() async {
    return await _remoteDataSource.roverList();
  }
}
