import 'package:nasa_space_data/src/domain/entities/photo_entity.dart';

abstract class PhotoRepository {
  Future<List<PhotoEntity>> photoList(DateTime earthDate,
      {String camera = "all", int page = 1});
}
