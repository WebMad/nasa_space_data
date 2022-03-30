import 'package:nasa_space_data/src/domain/entities/rover_entity.dart';

abstract class RoverState {}

class RoverInitState extends RoverState {}

class RoverLoadState extends RoverState {}

class RoverLoadErrorState extends RoverState {
  final String msg;

  RoverLoadErrorState(this.msg);
}

class RoverLoadedState extends RoverState {
  final List<RoverEntity> rovers;

  RoverLoadedState(this.rovers);
}
