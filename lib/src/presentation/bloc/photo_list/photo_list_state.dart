import 'package:nasa_space_data/src/domain/entities/photo_entity.dart';

abstract class PhotoListState {}

class PhotoListInitial extends PhotoListState {}

class PhotoListLoadState extends PhotoListState {}

class PhotoListLoadErrorState extends PhotoListState {
  final String msg;

  PhotoListLoadErrorState(this.msg);
}

class PhotoListLoadedState extends PhotoListState {
  final List<PhotoEntity> photos;

  PhotoListLoadedState({required this.photos});
}

class PhotoListAdditionLoadingState extends PhotoListLoadedState {
  PhotoListAdditionLoadingState({required List<PhotoEntity> photos})
      : super(photos: photos);
}
