import 'package:equatable/equatable.dart';
import 'package:nasa_space_data/src/domain/entities/camera_entity.dart';
import 'package:nasa_space_data/src/domain/entities/rover_entity.dart';

class PhotoEntity extends Equatable {
  final int id;
  final int sol;
  final CameraEntity camera;
  final String imgSrc;
  final DateTime earthDate;
  final RoverEntity rover;

  const PhotoEntity(
      {required this.id,
      required this.sol,
      required this.camera,
      required this.imgSrc,
      required this.earthDate,
      required this.rover});

  @override
  List<Object?> get props => [id, sol, camera, imgSrc, earthDate, rover];
}
