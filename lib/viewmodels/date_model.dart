import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:seatwashing/services/database_service.dart';
import 'package:seatwashing/services/date_service.dart';

import '../models/daterequest.dart';

class DateModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DateService _dateService = DateService();

  createDate(String date) async {
    //print(date);
    //print('su anki kullanici ${_auth.currentUser!.uid}');
    _dateService.createDateRequest(_auth.currentUser!.uid, date);
  }

  final DatabaseService _service = DatabaseService();
  final String _reference = 'DateRequest';

  Stream<List<DateRequest>> getDateRequestInformation() {
    // stream<QuerySnapshot> --> Stream<List<DocumentSnapshot>>
    Stream<List<DocumentSnapshot>> streamListDocument =
        _service //yani kullanıcı listesi
            .getPrivateDate(_reference, _auth.currentUser!.uid)
            .map((querySnapshot) => querySnapshot
                .docs); //DocumentSnapshotlara ait bir map -> getDateRequest stream olarak dönüyor çünkü .snapshots metodu eklenmiş

    //Stream<List<DocumentSnapshot>> --> Stream<List<DateRequestList>>

    var streamListDateOfRequest = streamListDocument.map((listOfSnap) =>
        listOfSnap
            .map<DateRequest>((docSnap) =>
                DateRequest.fromMap(docSnap.data() as Map<String, dynamic>))
            .toList());

    return streamListDateOfRequest;
  }

  deleteRequest(String userId) async {
    print(userId);
    await _service.getCollection(_reference).doc(userId).delete();
  }
}
