import 'package:flutter/material.dart';
import 'package:seatwashing/components/toast_message.dart';
import 'package:seatwashing/view/sign_in_page.dart';
import 'package:seatwashing/services/auth_service.dart';

import '../components/rounded_button.dart';
import '../components/rounded_inputs.dart';
import 'admin_page.dart';
import 'date_page.dart';

/// Silinen kullanıcı giriş yapamasın///
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? phoneNumberControl = TextEditingController();
  TextEditingController? passwordControl = TextEditingController();
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    //double viewInset = MediaQuery.of(context).viewInsets.bottom;
    double defaultLoginSize = size.height - (size.height * 0.2);
    //double defaultRegisterSize = size.height - (size.height * 0.1);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              //width: size.width,
              //height: defaultLoginSize,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'HOŞ GELDİNİZ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Image.asset('images/seat_login_logo.png'),
                  RoundedInput(
                    size: size,
                    hintText: 'Telefon Numarası',
                    textIcon: Icons.phone,
                    inputType: TextInputType.phone,
                    controller: phoneNumberControl,
                  ),
                  const SizedBox(height: 10),
                  RoundedButton(
                    size: size,
                    buttonName: 'GİRİŞ YAP',
                    function: () async {
                      if (phoneNumberControl!.text.isNotEmpty) {
                        //veritabanı komutları
                        if (phoneNumberControl!.text == '0') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AdminPage()),
                          );
                        } else {
                          var chechkUser = await authService
                              .signIn(phoneNumberControl!.text.toString());
                          if (chechkUser == true) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DatePage()),
                            );
                          } else {
                            ToastMessage.ToastMessageShow(
                                'Telefon numaranızı kontrol ediniz');
                          }
                        }
                      } else {
                        ToastMessage.ToastMessageShow(
                            'Lütfen telefon numarasını giriniz');
                      }
                    },
                  ),
                  RoundedButton(
                    size: size,
                    buttonName: 'KAYIT OL',
                    function: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
