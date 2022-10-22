import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final bool requestStatus = true;
  Future<bool?> createUser(
      String name, String surname, String phoneNumber, String address) async {
    try {
      var user = await _auth.createUserWithEmailAndPassword(
          email: '$phoneNumber@gmail.com', password: '123456');

      await _firestore.collection('Users').doc(user.user!.uid).set({
        'userId': user.user!.uid,
        'name': name,
        'surname': surname,
        'phoneNumber': phoneNumber,
        'address': address,
        'requestStatus': requestStatus
      });
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool?> signIn(String phoneNumber) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: '$phoneNumber@gmail.com', password: '123456');
      return true;
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        return false;
      }
    }
    return null;
  }

  Future deleteUser(String phoneNumber) async {
    var user = _auth.currentUser;
    print(user);

    try {
      AuthCredential _authCredential = EmailAuthProvider.credential(
          email: '$phoneNumber@gmail.com', password: '123456');
      var result = await user?.reauthenticateWithCredential(_authCredential);
      await result!.user?.delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> updateAuth(String phoneNumber) async {
    print("2. numara $phoneNumber");
    try {
      await _auth.currentUser!.updateEmail('$phoneNumber@gmail.com');
      return true;
    } catch (e) {
      print('Hata mesajı : {$e.toString()}');
      return false;
    }
  }

  signOut() async {
    return await _auth.signOut();
  }
}
