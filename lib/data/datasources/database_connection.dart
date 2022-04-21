import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseConnection {

  Firestore call() =>
    Firestore.instance;

}