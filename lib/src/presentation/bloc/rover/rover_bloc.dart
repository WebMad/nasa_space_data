import 'package:nasa_space_data/common/bloc_base.dart';
import 'package:nasa_space_data/common/exceptions.dart';
import 'package:nasa_space_data/src/domain/use_cases/rover_list_use_case.dart';
import 'package:nasa_space_data/src/presentation/bloc/rover/rover_event.dart';
import 'package:nasa_space_data/src/presentation/bloc/rover/rover_state.dart';
import 'package:nasa_space_data/service_locator.dart';

class RoverBloc extends BlocBase<RoverState, RoverEvent> {
  RoverBloc() : super(RoverInitState()) {
    on<LoadRoverListEvent>(_onLoadRoverListEvent);
  }

  _onLoadRoverListEvent(LoadRoverListEvent e) async {
    emit(RoverLoadState());
    try {
      emit(RoverLoadedState(
          await sl<RoverListUseCase>().call(RoverListParams())));
    } on Exception {
      emit(RoverLoadErrorState("Ошибка запроса"));
    }
  }
}
