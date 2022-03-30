abstract class PhotoListEvent {}

class PhotoListLoadEvent extends PhotoListEvent {
  final String rover;
  final String camera;
  final DateTime earthDate;
  final bool changedDate;

  PhotoListLoadEvent(
      {required this.rover,
      required this.camera,
      required this.earthDate,
      this.changedDate = false});
}
