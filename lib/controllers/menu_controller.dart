import 'package:cloud_firestore/cloud_firestore.dart';

class FoodMenuController {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  String collection = "menu";

  getMenu() {
    return fireStore.collection(collection).snapshots();
  }
}
