import 'package:equatable/equatable.dart';

class CameraEntity extends Equatable {
  final int id;
  final String name;
  final String fullName;
  final int roverId;

  const CameraEntity(
      {required this.id,
      required this.name,
      required this.fullName,
      required this.roverId});

  @override
  List<Object?> get props => [id, name, fullName, roverId];
}
