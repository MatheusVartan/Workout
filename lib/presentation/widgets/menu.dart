import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:workout/domain/entities/exercise.dart';
import 'package:workout/domain/usercases/get_exercises.dart';
import 'package:workout/domain/usercases/get_pose_by_exercise_id.dart';
import 'package:workout/domain/utils/pose_utils.dart';
import 'package:workout/presentation/widgets/render.dart';

class Menu extends StatefulWidget {
  final List<CameraDescription> cameras;

  Menu(this.cameras);

  @override
  _MenuState createState() => new _MenuState();
}

class _MenuState extends State<Menu> {
  var _getExercises = GetExercises();
  var _getPoseByExerciseId = GetPoseByExerciseId();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Exercise>>(
        future: _getExercises(),
        builder: (context, AsyncSnapshot<List<Exercise>> snapshot) {
          if (snapshot.hasData) {
            return Flexible(
              child: GridView.count(
                  childAspectRatio: 1.0,
                  padding: EdgeInsets.only(left: 16, right: 16),
                  crossAxisCount: 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  children: snapshot.data.map((data) {
                    return GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.network(data.image, width: 150.0),
                              SizedBox(
                                height: 14,
                              ),
                              Text(
                                data.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 8,
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          _getPoseByExerciseId(data.id).then((poses) {
                            PoseUtils.addPoses(poses);
                          }).whenComplete(() =>
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Render(widget.cameras),
                                ),
                              ));
                        });
                  }).toList()),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
