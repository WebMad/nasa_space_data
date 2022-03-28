import 'package:equatable/equatable.dart';
import 'package:nasa_space_data/common/use_case.dart';
import 'package:nasa_space_data/src/domain/entities/rover_entity.dart';
import 'package:nasa_space_data/src/domain/repositories/rover_repository.dart';

class RoverListUseCase extends UseCase<List<RoverEntity>, RoverListParams> {
  final RoverRepository _roverRepository;

  RoverListUseCase(this._roverRepository);

  @override
  Future<List<RoverEntity>> call(RoverListParams params) async {
    return await _roverRepository.roverList();
  }
}

class RoverListParams extends Equatable {
  @override
  List<Object?> get props => [];
}
