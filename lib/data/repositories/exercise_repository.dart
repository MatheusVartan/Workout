import 'dart:async';

import 'package:workout/data/datasources/database_connection.dart';
import 'package:workout/domain/entities/exercise.dart';
import 'package:workout/domain/entities/pose.dart';
import 'package:workout/domain/repositories/exercise_repository.dart';

class ExerciseRepository implements IExerciseRepository {
  final DataBaseConnection dbConnection;
  static const String mainCollectionName = "exercises";

  ExerciseRepository(this.dbConnection);

  @override
  Future<List<Pose>> getPoses(String exerciseId) async {
    var completer = Completer<List<Pose>>();

    var conn = this.dbConnection();

    List<Pose> poses = List<Pose>();

    for (int i = 1; i <= 2; i++) {
      var pose = await conn.collection(mainCollectionName).document(exerciseId).collection("pose$i").getDocuments();
      poses.add(Pose.fromQuery(pose));
    }

    completer.complete(poses);

    return completer.future;
  }

  @override
  Future<List<Exercise>> getExercises() async {
    var completer = Completer<List<Exercise>>();

    var conn = this.dbConnection();

    var ref = await conn.collection(mainCollectionName).getDocuments();

    completer
        .complete(ref.documents.map((ds) => Exercise.fromSnap(ds)).toList());

    return completer.future;
  }
}
