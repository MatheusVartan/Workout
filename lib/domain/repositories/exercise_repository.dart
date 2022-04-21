import 'package:workout/domain/entities/exercise.dart';
import 'package:workout/domain/entities/pose.dart';

abstract class IExerciseRepository {
  Future<List<Pose>> getPoses(String exerciseId);
  Future<List<Exercise>> getExercises();
}