import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:seatwashing/components/constants.dart';
import 'package:seatwashing/components/rounded_button.dart';
import 'package:seatwashing/components/rounded_inputs.dart';
import 'package:seatwashing/components/toast_message.dart';
import 'package:seatwashing/services/auth_service.dart';
import 'package:seatwashing/viewmodels/date_model.dart';

import '../models/daterequest.dart';
import '../viewmodels/date_request_model.dart';

class DatePage extends StatefulWidget {
  const DatePage({Key? key}) : super(key: key);

  @override
  State<DatePage> createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  String? writeDate, writeDay, writeComplete, writeCompleteSend;
  final DateModel _model = DateModel();

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
        automaticallyImplyLeading: false,
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
                    RoundedButton(
                      function: () {
                        if (writeDate != null && writeDay != null) {
                          writeCompleteSend = '$writeDate/$writeDay';
                          _model.createDate(
                              writeCompleteSend!); //önce veritabanını bekle
                          ToastMessage.ToastMessageShow(
                              'Randevu İsteğiniz Gönderilmiştir.');
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
              Expanded(child: DateStateCard())
            ],
          ),
        ),
      ),
    );
  }
}

class DateStateCard extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  DateStateCard({Key? key}) : super(key: key);
  DateModel _model = DateModel();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DateModel>(
      create: (_) => DateModel(),
      builder: (context, child) => Scaffold(
        body: Center(
            child: Column(
          children: [
            StreamBuilder<List<DateRequest>>(
              stream: Provider.of<DateModel>(context, listen: false)
                  .getDateRequestInformation(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<DateRequest>> asyncSnapshot) {
                if (asyncSnapshot.hasError) {
                  return const Center(
                    child: Text('hata oluştu'),
                  );
                } else {
                  if (!asyncSnapshot.hasData) {
                    return const CircularProgressIndicator();
                  } else {
                    var dateList = asyncSnapshot.data;
                    return Flexible(
                        child: Column(
                      children: [
                        Center(
                          child: Text(
                            dateList!.isNotEmpty ? 'Randevu Durumu' : '',
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: dateList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                child: ListTile(
                                  title: Text(
                                    dateList[index].dateDay!,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(
                                    dateList[index].date!,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  tileColor: kPrimaryColor.withAlpha(50),
                                  trailing: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        splashColor: Colors.red,
                                        onTap: () async {
                                          _model.deleteRequest(
                                              dateList[index].userId!);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Text('İptal Et'),
                                            SizedBox(width: 5),
                                            Icon(
                                              Icons.cancel,
                                              color: Colors.red,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                          dateList[index].requestStatus == false
                                              ? 'Randevunuz Beklemede'
                                              : 'Randevunuz Onaylandı'),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ],
                    ));
                  }
                }
              },
            )
          ],
        )),
      ),
    );
  }
}

/*
class DateStateCard2 extends StatelessWidget {
  const DateStateCard2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: const Text(
          'Çarşamba',
          style: TextStyle(fontSize: 20),
        ),
        subtitle: const Text(
          '2.02.2022',
          style: TextStyle(fontSize: 16),
        ),
        tileColor: kPrimaryColor.withAlpha(50),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              splashColor: Colors.red,
              onTap: () {
                print("push inkwell");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('İptal Et'),
                  SizedBox(width: 5),
                  Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            const Text('Bekleyen Randevu'),
          ],
        ),
      ),
    );
  }
}

*/

/*

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seatwashing/components/constants.dart';
import 'package:seatwashing/components/rounded_button.dart';
import 'package:seatwashing/components/rounded_inputs.dart';
import 'package:seatwashing/components/toast_message.dart';
import 'package:seatwashing/services/auth_service.dart';
import 'package:seatwashing/viewmodels/date_model.dart';

class DatePage extends StatefulWidget {
  const DatePage({Key? key}) : super(key: key);

  @override
  State<DatePage> createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  String? writeDate, writeDay, writeComplete, writeCompleteSend;
  final DateModel _model = DateModel();
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
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 8, bottom: 8, right: 8, left: 8),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kPrimaryColor)),
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
                RoundedButton(
                  function: () {
                    if (writeDate != null && writeDay != null) {
                      writeCompleteSend = '$writeDate/$writeDay';
                      _model.createDate(
                          writeCompleteSend!); //önce veritabanını bekle
                      ToastMessage.ToastMessageShow(
                          'Randevu İsteğiniz Gönderilmiştir.');
                    } else {
                      ToastMessage.ToastMessageShow('Lüften Tarih şeçiniz');
                    }
                  },
                  buttonName: 'Onayla',
                  size: size,
                ),
                //const Text('Randevu isteğiniz gönderilmiştir.'),

                const SizedBox(
                  height: 40,
                ),
                const Center(
                  child: Text(
                    'Randevu Durumu',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                const Divider(
                  color: Colors.black,
                ),
                Card(
                  child: ListTile(
                    title: const Text(
                      'Çarşamba',
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: const Text(
                      '2.02.2022',
                      style: TextStyle(fontSize: 16),
                    ),
                    tileColor: kPrimaryColor.withAlpha(50),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          splashColor: Colors.red,
                          onTap: () {
                            print("push inkwell");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text('İptal Et'),
                              SizedBox(width: 5),
                              Icon(
                                Icons.cancel,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                        const Text('Bekleyen Randevu'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}



*/