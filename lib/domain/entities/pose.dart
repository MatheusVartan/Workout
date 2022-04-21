import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout/domain/entities/position.dart';

class Pose {
  List<Position> positions;

  Pose(this.positions);

  factory Pose.fromQuery(QuerySnapshot qr) {
    var positions = List<Position>();

    for (int i = 0; i <= 16; i++) {
      var document = qr.documents.firstWhere((element) => element.documentID == i.toString());

      positions.add(Position(double.parse(document.data['x'].toString()), double.parse(document.data['y'].toString())));
    }

    return Pose(positions);
  }
}
