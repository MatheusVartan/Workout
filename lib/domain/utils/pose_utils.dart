import 'package:workout/domain/entities/pose.dart';

class PoseUtils {
  static List<Pose> staticPoses;

  static addPoses(List<Pose> poses) => staticPoses = poses;
}