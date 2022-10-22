import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:seatwashing/components/constants.dart';
import 'package:seatwashing/components/rounded_button.dart';
import 'package:seatwashing/components/rounded_inputs.dart';
import 'package:seatwashing/components/toast_message.dart';
import 'package:seatwashing/services/auth_service.dart';
import 'package:seatwashing/viewmodels/AdminDateAdd_model.dart';
import 'package:seatwashing/viewmodels/date_model.dart';

import '../models/daterequest.dart';
import '../viewmodels/date_request_model.dart';

class AdminDateAdd extends StatefulWidget {
  const AdminDateAdd({Key? key}) : super(key: key);

  @override
  State<AdminDateAdd> createState() => _AdminDateAddState();
}

class _AdminDateAddState extends State<AdminDateAdd> {
  List<TextEditingController?> controller =
      List.generate(4, (i) => TextEditingController());

  String? writeDate, writeDay, writeComplete, writeCompleteSend;
  final AdminDateAddModel _model = AdminDateAddModel();
  // ignore: non_constant_identifier_names
  String DateDayFormatter(int day) {
    String gonder = '';
    switch (day) {
      case 1:
        gonder = 'Pazartesi';
        break;
      case 2:
        gonder = 'Salı';
        break;
      case 3:
        gonder = 'Çarşamba';
        break;
      case 4:
        gonder = 'Perşembe';
        break;
      case 5:
        gonder = 'Cuma';
        break;
      case 6:
        gonder = 'Cumartesi';
        break;
      case 7:
        gonder = 'Pazar';
        break;
    }
    return gonder;
  }

  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Randevu Ekranı'),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kPrimaryColor)),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    RoundedButton(
                      function: () {
                        showDatePicker(
                          locale: const Locale('tr', 'TR'),
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year,
                              DateTime.now().month, DateTime.now().day + 14),
                        ).then((date) {
                          setState(() {
                            writeDate = DateFormat('dd-MM-yyyy').format(date!);
                            writeDay = DateDayFormatter(date.weekday);
                            writeComplete = '$writeDate\t\t$writeDay';
                          });
                        });
                      },
                      buttonName: 'Tarih Seçiniz',
                      size: size,
                    ),
                    RoundedInput(
                      size: size,
                      enabled: false,
                      hintText: writeComplete ?? 'Seçilen Tarih',
                    ),
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
                      controller: controller[3],
                      maxLine: 3,
                    ),
                    RoundedButton(
                      function: () async {
                        if (writeDate != null && writeDay != null) {
                          writeCompleteSend = '$writeDate/$writeDay';
                          for (int i = 0; i < 6; i++) {
                            if (controller[i]!.text.isEmpty) {
                              ToastMessage.ToastMessageShow(
                                  'Boş alanları doldurunuz');
                              return;
                            } else {
                              var checkCreateUser = await _model.createUser(
                                  controller[0]!.text.toString(),
                                  controller[1]!.text.toString(),
                                  controller[2]!.text.toString(),
                                  controller[3]!.text.toString(),
                                  writeDate.toString(),
                                  writeDay.toString());
                              if (checkCreateUser == true) {
                                ToastMessage.ToastMessageShow(
                                    'Kayıt istediği gönderildi');
                              } else {
                                ToastMessage.ToastMessageShow(
                                    'Kayıt istediği gönderilemedi');
                              }
                              return;
                            }
                          }
                        } else {
                          ToastMessage.ToastMessageShow('Lüften Tarih şeçiniz');
                        }
                      },
                      buttonName: 'Onayla',
                      size: size,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
