import 'package:seatwashing/services/auth_service.dart';

class SignInModel {
  final AuthService _authService = AuthService();

  Future<bool?> singIn(
      String name, String surname, String phoneNumber, String address) async {
    var state =
        await _authService.createUser(name, surname, phoneNumber, address);

    return state;
  }
}
