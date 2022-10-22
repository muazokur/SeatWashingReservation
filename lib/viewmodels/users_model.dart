// ignore_for_file: unrelated_type_equality_checks
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:seatwashing/services/auth_service.dart';
import 'package:seatwashing/services/database_service.dart';

import '../models/users.dart';

class UsersModel extends ChangeNotifier {
  final DatabaseService _service = DatabaseService();
  final String _reference = 'Users';
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<Users>> getUsersInformation() {
    const String _reference = 'Users';

    // stream<QuerySnapshot> --> Stream<List<DocumentSnapshot>>
    Stream<List<DocumentSnapshot>> streamListDocument =
        _service //yani kullanıcı listesi
            .getDataUsers(_reference)
            .map((querySnapshot) => querySnapshot
                .docs); //DocumentSnapshotlara ait bir map -> getUsers, stream olarak dönüyor çünkü .snapshots metodu eklenmiş

    //Stream<List<DocumentSnapshot>> --> Stream<List<UsersList>>

    var streamListUsers = streamListDocument.map((listOfSnap) => listOfSnap
        .map<Users>(
            (docSnap) => Users.fromMap(docSnap.data() as Map<String, dynamic>))
        .toList());

    return streamListUsers;
  }

  deleteUser(String userId, String phoneNumber) async {
    await _authService.deleteUser(phoneNumber);
    //print(userId);
    await _service.getCollection(_reference).doc(userId).delete();
  }

  Future<bool?> userUpdate(String userId, String name, String surname,
      String phoneNumber, String address) async {
    print(phoneNumber);
    await _authService.updateAuth(phoneNumber);

    try {
      await _firestore.collection('Users').doc(userId).set({
        'userId': userId,
        'name': name,
        'surname': surname,
        'phoneNumber': phoneNumber,
        'address': address,
        'requestStatus': true,
      });
      return true;
    } on Exception {
      return false;
    }
  }
}
