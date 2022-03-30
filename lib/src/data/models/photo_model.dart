import 'package:nasa_space_data/src/data/models/camera_model.dart';
import 'package:nasa_space_data/src/data/models/rover_model.dart';
import 'package:nasa_space_data/src/domain/entities/camera_entity.dart';
import 'package:nasa_space_data/src/domain/entities/photo_entity.dart';
import 'package:nasa_space_data/src/domain/entities/rover_entity.dart';

class PhotoModel extends PhotoEntity {
  const PhotoModel(
      {required int id,
      required int sol,
      required CameraModel camera,
      required String imgSrc,
      required DateTime earthDate,
      required RoverModel rover})
      : super(
            id: id,
            sol: sol,
            camera: camera,
            imgSrc: imgSrc,
            earthDate: earthDate,
            rover: rover);

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
        id: json["id"],
        sol: json["sol"],
        camera: CameraModel.fromJson(json["camera"]),
        imgSrc: json["img_src"],
        earthDate: DateTime.parse(json["earth_date"]),
        rover: RoverModel.fromJson(json["rover"]));
  }
}
