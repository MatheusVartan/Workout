import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout/domain/entities/pose.dart';

class Exercise {
  String id, name, image;
  List<Pose> poses;

  Exercise(this.id, this.name, this.image, { this.poses });

  factory Exercise.fromSnap(DocumentSnapshot ds) {
    Map data = ds.data;

    var exercise = Exercise(
        ds.documentID,
        data['name'],
        data['image']
    );

    return exercise;
  }
}