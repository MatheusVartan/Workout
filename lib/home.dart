import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:workout/presentation/widgets/menu.dart';

class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;

  HomePage(this.cameras);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 110,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Workout",
                        style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Escolha um exercício",
                        style: TextStyle(
                                color: Colors.black45,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Menu(widget.cameras)
          ],
        )
    );
  }
}
