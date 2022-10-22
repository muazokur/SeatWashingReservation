import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:seatwashing/services/database_service.dart';

import '../models/daterequest.dart';

class DateRequestModel extends ChangeNotifier {
  final DatabaseService _service = DatabaseService();
  final String _reference = 'DateRequest';

  Stream<List<DateRequest>> getDateRequestInformation() {
    // stream<QuerySnapshot> --> Stream<List<DocumentSnapshot>>
    Stream<List<DocumentSnapshot>> streamListDocument =
        _service //yani kullanıcı listesi
            .getDateRequest(_reference)
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

  dateRequestAdmitIt(String userId) async {
    await _service
        .getCollection(_reference)
        .doc(userId)
        .update({'requestStatus': true});
    print(userId);
  }

  deleteRequest(String userId) async {
    print(userId);
    await _service.getCollection(_reference).doc(userId).delete();
  }
}
