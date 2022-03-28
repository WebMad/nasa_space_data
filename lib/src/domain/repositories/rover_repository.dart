import 'package:nasa_space_data/src/domain/entities/rover_entity.dart';

abstract class RoverRepository {
  Future<List<RoverEntity>> roverList();
}