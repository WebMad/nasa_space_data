import 'package:nasa_space_data/src/data/data_sources/nasa_remote_data_source.dart';
import 'package:nasa_space_data/src/domain/entities/photo_entity.dart';
import 'package:nasa_space_data/src/domain/repositories/photo_repository.dart';

class PhotoRepositoryImpl extends PhotoRepository {
  final NasaRemoteDataSource _remoteDataSource;

  PhotoRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<PhotoEntity>> photoList(DateTime earthDate, String rover,
      {String camera = "all", int page = 1}) async {
    return await _remoteDataSource.photoList(earthDate, rover,
        camera: camera, page: page);
  }
}
