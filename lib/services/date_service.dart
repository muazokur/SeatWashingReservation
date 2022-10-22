import 'package:cloud_firestore/cloud_firestore.dart';

class DateService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool?> createDateRequest(String userId, String date) async {
    try {
      CollectionReference userRef = _firestore.collection('Users');
      var denemeRef = userRef.doc(userId);

      var response = await denemeRef.get();

      dynamic user = response.data();

      var dateSplit = date.split("/");

      bool requestStatus = false;

      await _firestore.collection('DateRequest').doc(userId).set({
        'userId': userId,
        'name': user['name'],
        'surname': user['surname'],
        'phoneNumber': user['phoneNumber'],
        'address': user['address'],
        'date': dateSplit[0],
        'day': dateSplit[1],
        'requestStatus': requestStatus,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  getUsers(String id) async {
    CollectionReference userRef = _firestore.collection('Users');

    QuerySnapshot querySnapshot = await userRef.get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(allData);
  }

  Future getData() async {
    CollectionReference userRef = _firestore.collection('Users');
    var denemeRef = userRef.doc('MAletqImHzdBkAq0b9PvMwfifjI2');

    var response = await denemeRef.get();

    dynamic veriMap = response.data();

    print(veriMap['name']);
  }

  Future<List<QueryDocumentSnapshot<Object?>>> getDataQuery() async {
    CollectionReference userRef = _firestore.collection('kullanicilar');
    var response = await userRef.get();
    var list = response.docs;

    return list;
  }
}
