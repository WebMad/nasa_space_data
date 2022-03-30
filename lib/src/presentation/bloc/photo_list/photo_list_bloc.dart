import 'package:nasa_space_data/common/bloc_base.dart';
import 'package:nasa_space_data/src/domain/entities/photo_entity.dart';
import 'package:nasa_space_data/src/domain/use_cases/photo_list_use_case.dart';
import 'package:nasa_space_data/src/presentation/bloc/photo_list/photo_list_event.dart';
import 'package:nasa_space_data/src/presentation/bloc/photo_list/photo_list_state.dart';
import 'package:nasa_space_data/service_locator.dart';

class PhotoListBloc extends BlocBase<PhotoListState, PhotoListEvent> {
  int page = 1;

  PhotoListBloc() : super(PhotoListInitial()) {
    on<PhotoListLoadEvent>(_onPhotoListLoadEvent);
  }

  _onPhotoListLoadEvent(PhotoListLoadEvent event) async {
    List<PhotoEntity> photos = [];

    if (event.changedDate) {
      page = 1;
    }

    if (state is PhotoListLoadedState && !event.changedDate) {
      photos.addAll((state as PhotoListLoadedState).photos);
    }
    if (photos.isEmpty) {
      emit(PhotoListLoadState());
    } else {
      emit(PhotoListAdditionLoadingState(photos: photos));
    }

    try {
      emit(
        PhotoListLoadedState(
          photos: photos
            ..addAll(
              await sl<PhotoListUseCase>().call(PhotoListParams(
                  earthDate: event.earthDate,
                  rover: event.rover,
                  camera: event.camera,
                  page: page)),
            ),
        ),
      );
      page++;
    } on Exception {
      emit(PhotoListLoadErrorState("Ошибка запроса"));
    }
  }
}
