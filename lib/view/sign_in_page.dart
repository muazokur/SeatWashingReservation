import 'package:flutter/material.dart';
import 'package:seatwashing/components/constants.dart';
import 'package:seatwashing/components/rounded_button.dart';
import 'package:seatwashing/components/rounded_inputs.dart';
import 'package:seatwashing/components/toast_message.dart';
import 'package:seatwashing/viewmodels/sign_in_model.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final SignInModel _signInModel = SignInModel();
  List<String> isimler = [];

  List<TextEditingController?> controller =
      List.generate(6, (i) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    //controller.add(TextEditingController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kullanıcı Kayıt Ekranı'),
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kPrimaryColor)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedInput(
                  size: MediaQuery.of(context).size,
                  hintText: 'Ad',
                  inputType: TextInputType.name,
                  textIcon: Icons.account_circle,
                  controller: controller[0],
                ),
                RoundedInput(
                  size: MediaQuery.of(context).size,
                  hintText: 'Soyad',
                  inputType: TextInputType.name,
                  textIcon: Icons.account_circle,
                  controller: controller[1],
                ),
                RoundedInput(
                  size: MediaQuery.of(context).size,
                  hintText: 'Telefon numarası',
                  inputType: TextInputType.number,
                  textIcon: Icons.phone,
                  controller: controller[2],
                ),
                RoundedInput(
                  size: MediaQuery.of(context).size,
                  hintText: '\nAdres',
                  textIcon: Icons.home,
                  inputType: TextInputType.multiline,
                  maxLine: 3,
                  controller: controller[3],
                ),
                RoundedButton(
                  size: MediaQuery.of(context).size,
                  buttonName: 'Kayıt Oluştur',
                  function: () async {
                    for (int i = 0; i < 6; i++) {
                      if (controller[i]!.text.isEmpty) {
                        ToastMessage.ToastMessageShow(
                            'Boş alanları doldurunuz');
                        return;
                      } else {
                        var checkCreateUser = await _signInModel.singIn(
                            controller[0]!.text.toString(),
                            controller[1]!.text.toString(),
                            controller[2]!.text.toString(),
                            controller[3]!.text.toString());
                        if (checkCreateUser == true) {
                          ToastMessage.ToastMessageShow(
                              'Kayıt istediği gönderildi');
                        } else {
                          ToastMessage.ToastMessageShow(
                              'Zaten böyle bir kullanıcı var');
                        }
                        return;
                      }
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
