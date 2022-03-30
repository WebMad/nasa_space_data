import 'package:equatable/equatable.dart';
import 'package:nasa_space_data/src/domain/entities/camera_entity.dart';

enum RoverStatus {
  active,
  complete,
}

class RoverEntity extends Equatable {
  final int id;
  final String name;
  final int totalPhotos;
  final DateTime landingDate;
  final DateTime launchDate;
  final DateTime maxDate;
  final RoverStatus status;
  final List<CameraEntity> cameras;

  const RoverEntity({
    required this.id,
    required this.name,
    required this.landingDate,
    required this.launchDate,
    required this.status,
    required this.totalPhotos,
    required this.maxDate,
    required this.cameras,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        totalPhotos,
        landingDate,
        launchDate,
        maxDate,
        status,
        cameras,
      ];
}
