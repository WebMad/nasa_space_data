import 'package:nasa_space_data/common/model.dart';
import 'package:nasa_space_data/src/domain/entities/camera_entity.dart';

class CameraModel extends CameraEntity {
  const CameraModel(
      {required int id,
      required String name,
      required String fullName,
      required int roverId})
      : super(id: id, name: name, fullName: fullName, roverId: roverId);

  factory CameraModel.fromJson(Map<String, dynamic> json) {
    return CameraModel(
        id: json["id"],
        name: json["name"],
        fullName: json["full_name"],
        roverId: json["rover_id"]);
  }
}
