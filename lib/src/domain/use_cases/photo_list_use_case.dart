import 'package:equatable/equatable.dart';
import 'package:nasa_space_data/common/use_case.dart';
import 'package:nasa_space_data/src/domain/entities/photo_entity.dart';
import 'package:nasa_space_data/src/domain/repositories/photo_repository.dart';

class PhotoListUseCase extends UseCase<List<PhotoEntity>, PhotoListParams> {
  final PhotoRepository _photoRepository;

  PhotoListUseCase(this._photoRepository);

  @override
  Future<List<PhotoEntity>> call(PhotoListParams params) async {
    return await _photoRepository.photoList(params.earthDate,
        camera: params.camera ?? "all", page: params.page ?? 1);
  }
}

class PhotoListParams extends Equatable {
  final DateTime earthDate;
  final String? camera;
  final int? page;

  const PhotoListParams({required this.earthDate, this.camera, this.page});

  @override
  List<Object?> get props => [earthDate, camera, page];
}
