import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:seatwashing/services/database_service.dart';

import '../models/users.dart';

class UsersRequestModel extends ChangeNotifier {
  final DatabaseService _service = DatabaseService();
  final String _reference = 'Users';

  Stream<List<Users>> getUsersInformation() {
    // stream<QuerySnapshot> --> Stream<List<DocumentSnapshot>>
    Stream<List<DocumentSnapshot>> streamListDocument =
        _service //yani kullanıcı listesi
            .getDataUserRequest(_reference)
            .map((querySnapshot) => querySnapshot
                .docs); //DocumentSnapshotlara ait bir map -> getUsers, stream olarak dönüyor çünkü .snapshots metodu eklenmiş

    //Stream<List<DocumentSnapshot>> --> Stream<List<UsersList>>

    var streamListUsers = streamListDocument.map((listOfSnap) => listOfSnap
        .map<Users>(
            (docSnap) => Users.fromMap(docSnap.data() as Map<String, dynamic>))
        .toList());

    return streamListUsers;
  }

  userAdmitIt(String phoneNumber) async {
    await _service
        .getCollection(_reference)
        .doc(phoneNumber)
        .update({'requestStatus': true});
    print(phoneNumber);
  }
}
