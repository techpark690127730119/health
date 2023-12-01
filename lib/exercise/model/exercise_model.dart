import '../../drift/database/database.dart';

class ExerciseModel {
  final String? part;
  final PartData? partData;
  final ExerciseData? exercise;

  ExerciseModel(
    this.part,
    this.partData,
    this.exercise,
  );

  ExerciseModel copyWith({
    String? part,
    PartData? partData,
    ExerciseData? exercise,
  }) {
    return ExerciseModel(
      part ?? this.part,
      partData ?? this.partData,
      exercise ?? this.exercise,
    );
  }
}
