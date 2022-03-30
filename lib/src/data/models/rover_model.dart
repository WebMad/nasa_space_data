import 'package:nasa_space_data/src/data/models/camera_model.dart';
import 'package:nasa_space_data/src/domain/entities/camera_entity.dart';
import 'package:nasa_space_data/src/domain/entities/rover_entity.dart';

class RoverModel extends RoverEntity {
  const RoverModel(
      {required int id,
      required String name,
      required DateTime landingDate,
      required DateTime launchDate,
      required RoverStatus status,
      required int totalPhotos,
      required DateTime maxDate,
      required List<CameraEntity> cameras})
      : super(
            id: id,
            name: name,
            landingDate: landingDate,
            launchDate: launchDate,
            status: status,
            totalPhotos: totalPhotos,
            maxDate: maxDate,
            cameras: cameras);

  factory RoverModel.fromJson(Map<String, dynamic> json) {
    return RoverModel(
        id: json["id"],
        name: json["name"],
        landingDate: DateTime.parse(json["landing_date"]),
        launchDate: DateTime.parse(json["launch_date"]),
        status: json["status"] == "complete"
            ? RoverStatus.complete
            : RoverStatus.active,
        totalPhotos: json["total_photos"],
        maxDate: DateTime.parse(json["max_date"]),
        cameras: (json["cameras"] as List<dynamic>)
            .map((e) => CameraModel.fromJson(e))
            .toList());
  }
}
