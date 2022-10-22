import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:seatwashing/models/users.dart';
import 'package:seatwashing/services/database_service.dart';
import 'package:collection/src/functions.dart';
import '../models/daterequest.dart';

class AddressGotoModel extends ChangeNotifier {
  final DatabaseService _service = DatabaseService();
  final String _reference = 'DateRequest';

  Stream<List<UsersToGo>> getAddressGotoInformation() {
    // stream<QuerySnapshot> --> Stream<List<DocumentSnapshot>>
    Stream<List<DocumentSnapshot>> streamListDocument =
        _service //yani kullanıcı listesi
            .getAddressToGo(_reference)
            .map((querySnapshot) => querySnapshot
                .docs); //DocumentSnapshotlara ait bir map -> getDateRequest stream olarak dönüyor çünkü .snapshots metodu eklenmiş

    //Stream<List<DocumentSnapshot>> --> Stream<List<DateRequestList>>

    var streamListAddressGoto = streamListDocument.map((listOfSnap) =>
        listOfSnap
            .map<UsersToGo>((docSnap) =>
                UsersToGo.fromMap(docSnap.data() as Map<String, dynamic>))
            .toList());

    return streamListAddressGoto;
  }

  getDate() async {
    List<String?> dates = [];
    var getGoto = getAddressGotoInformation();
    var data = await getGoto.first;

    List<Map<String, dynamic>> veriler = [];

    for (int i = 0; i < data.length; i++) {
      veriler.add(data[i].toMap());
    }

    var x = groupBy(veriler, (Map obj) => obj['date']);

    var y = groupBy(veriler, (Map obj) => obj['date']).values.toList();

    //print(y);
    print(y);
    return y;

    //print(data[0].date);
    //print(data.length);
  }

  getDate2() async {
    var s = await getDate();
    print(s);
  }
}
