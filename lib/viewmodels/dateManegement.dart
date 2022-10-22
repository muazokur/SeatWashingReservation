import 'package:flutter/material.dart';
import 'package:seatwashing/components/constants.dart';
import 'package:seatwashing/components/rounded_button.dart';
import 'package:intl/intl.dart';

class DateManagementPage extends StatefulWidget {
  const DateManagementPage({Key? key}) : super(key: key);

  @override
  State<DateManagementPage> createState() => _DateManagementPageState();
}

class _DateManagementPageState extends State<DateManagementPage> {
  String? writeDate, writeDay, writeComplete, writeCompleteSend;

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gün Ayarları'),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        RoundedButton(
          function: () {
            showDatePicker(
              locale: const Locale('tr', 'TR'),
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day + 14),
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
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Kapatılan Günler",
          style: TextStyle(fontSize: 24),
        ),
        const Divider(),
      ]),
    );
  }
}
