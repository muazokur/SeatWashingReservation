import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDateAddModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<bool?> createUser(String name, String surname, String phoneNumber,
      String address, String date, String day) async {
    String userId = DateTime.now().toString();
    try {
      await _firestore.collection('DateRequest').doc(userId).set({
        'userId': userId,
        'name': name,
        'surname': surname,
        'phoneNumber': phoneNumber,
        'address': address,
        'requestStatus': true,
        'date': date,
        'day': day,
      });
      return true;
    } on Exception {
      return false;
    }
  }
}
