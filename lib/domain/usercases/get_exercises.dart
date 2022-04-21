import 'package:workout/data/datasources/database_connection.dart';
import 'package:workout/data/repositories/exercise_repository.dart';
import 'package:workout/domain/entities/exercise.dart';
import 'package:workout/domain/repositories/exercise_repository.dart';

class GetExercises {
  IExerciseRepository _repository = ExerciseRepository(DataBaseConnection());

  Future<List<Exercise>> call() async =>
      await _repository.getExercises();
}