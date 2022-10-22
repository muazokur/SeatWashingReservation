import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getData(String referencePath) {
    return _firestore.collection(referencePath).snapshots();
  }

  CollectionReference getCollection(String referencePath) {
    return _firestore.collection(referencePath);
  }


  Stream<QuerySnapshot> getPrivateDate(String referencePath, String userid) {
    print('selam');
    return _firestore
        .collection(referencePath)
        .where('userId', isEqualTo: userid)
        .snapshots();
  }

  Stream<QuerySnapshot> getDateRequest(String referencePath) {
    return _firestore
        .collection(referencePath)
        .where('requestStatus', isEqualTo: false)
        .snapshots();
  }

  Stream<QuerySnapshot> getAddressToGo(String referencePath) {
    return _firestore
        .collection(referencePath)
        .where('requestStatus', isEqualTo: true) //true yap
        .snapshots();
  }

  Stream<QuerySnapshot> getDataUserRequest(String referencePath) {
    return _firestore
        .collection(referencePath)
        .where('requestStatus', isEqualTo: false)
        .snapshots();
  }

  Stream<QuerySnapshot> getDataUsers(String referencePath) {
    return _firestore
        .collection(referencePath)
        .where('requestStatus', isEqualTo: true)
        .snapshots();
  }
}
