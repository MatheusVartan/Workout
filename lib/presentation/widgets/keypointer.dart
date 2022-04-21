import 'package:flutter/material.dart';
import 'package:workout/domain/entities/position.dart';
import 'package:workout/domain/utils/keypoint_utils.dart';
import 'package:workout/domain/utils/pose_utils.dart';

class Keypointer extends StatelessWidget {
  final List<dynamic> results;
  static int poseIndex = 0;
  static int reps = 0;
  final List<bool> keypointMatches = List<bool>();
  final int previewH, previewW;
  final double screenH, screenW;

  Keypointer(
      this.results, this.previewH, this.previewW, this.screenH, this.screenW);

  @override
  Widget build(BuildContext context) {
    //List<String> partes = [ "0 nariz", "1 olhoEsq", "2 olhoDir", "3 orelhaEsq", "4 orelhaDir", "5 ombroEsq", "6 ombroDir", "7 cotoveloEsq", "8 cotoveloDir", "9 pulsoEsq", "10 pulsoDir", "11 quadrilEsq", "12 quadrilDir", "13 joelhoEsq", "14 joelhoDir", "15 tornozeloEsq", "16 tornozeloDir" ];

    var exercisePoses = PoseUtils.staticPoses;

    List<Widget> _renderKeypoints() {
      var lists = <Widget>[];
      var visibleParts = 0;

      results.forEach((result) {
        var keypoints = List<dynamic>.from(result["keypoints"].values);

        var list = keypoints.map<Widget>((keypoint) {
          var _index = keypoints.indexOf(keypoint);
          var _part = exercisePoses[poseIndex].positions[_index];

          var _x = keypoint["x"];
          var _y = keypoint["y"];

          var match = KeypointerUtils.isMatch(_x, _y, _part.x, _part.y);
          var visiblePart = _part.x != 0.0 && _part.y != 0.0;

//          visiblePart = true;

          if (visiblePart) {
            keypointMatches.add(match);
            visibleParts++;
          }

          var pos =
              getAdjustedXandY(_x, _y, screenH, screenW, previewH, previewW);

          var x = pos.x;
          var y = pos.y;

          var text = !visiblePart
              ? ""
//              : "● ${_x.toStringAsPrecision(2)}, ${_y.toStringAsPrecision(2)}";
              : "●";

          return _getPositioned(
              x,
              y,
              text,
              match ? Colors.lightGreenAccent : Colors.redAccent,
              100.0,
              20.0,
              14.0);
        }).toList();

        lists.addAll(list);
      });

      lists.addAll(_renderObjective(exercisePoses[poseIndex].positions));

      lists.add(_getPositioned(50.0, 100.0, "Repetições: $reps",
          Theme.of(context).accentColor, 150.0, 22.0, 18.0));

      if (visibleParts > 0 &&
          keypointMatches.length >= visibleParts &&
          !keypointMatches.contains(false)) {
        poseIndex = poseIndex == 0 ? 1 : 0;
        if (poseIndex == 0) reps++;
      }

      return lists;
    }

    return Stack(children: _renderKeypoints());
  }

  List<Widget> _renderObjective(List<Position> objective) {
//    List<dynamic> a = List<dynamic>();
//    for(double i = 0.05; i < 1; i+=0.05){
//      for(double j = 0.05; j < 1; j+=0.05){
//        a.add({"x": i, "y": j});
//      }
//    }

    return objective.map<Widget>((k) {
      var pos =
          getAdjustedXandY(k.x, k.y, screenH, screenW, previewH, previewW);

      return _getPositioned(pos.x, pos.y, "●", Colors.white, 100.0, 18.0, 12.0);
    }).toList();
  }

  Positioned _getPositioned(x, y, text, color, width, height, fontSize) =>
      Positioned(
        left: x - 6,
        top: y - 6,
        width: width,
        height: height,
        child: Container(
          child: Text(
            text,
            style: TextStyle(
                color: color, fontSize: fontSize, fontWeight: FontWeight.bold),
          ),
        ),
      );
}
