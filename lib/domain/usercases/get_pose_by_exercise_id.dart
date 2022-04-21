import 'package:workout/data/datasources/database_connection.dart';
import 'package:workout/data/repositories/exercise_repository.dart';
import 'package:workout/domain/entities/pose.dart';
import 'package:workout/domain/repositories/exercise_repository.dart';

class GetPoseByExerciseId {
  IExerciseRepository _repository = ExerciseRepository(DataBaseConnection());

  Future<List<Pose>> call(String exerciseId) async => await _repository.getPoses(exerciseId);
}
