import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seatwashing/components/application_my_card.dart';
import 'package:seatwashing/models/users.dart';
import 'package:seatwashing/viewmodels/address_goto_model.dart';
import 'package:seatwashing/viewmodels/date_model.dart';
import 'package:seatwashing/viewmodels/users_model.dart';
import 'package:collection/src/functions.dart';
import '../components/admin_pages_view_setting.dart';
import '../components/card_button.dart';
import '../components/constants.dart';
import 'package:intl/intl.dart';

class AddressToGo extends StatelessWidget {
  const AddressToGo({Key? key}) : super(key: key);

  List<Map<String, dynamic>> listConvertIterable(List<UsersToGo>? list) {
    List<Map<String, dynamic>> liste = [];

    liste.clear();
    List<DateTime> converDate = [];
    for (int i = 0; i < list!.length; i++) {
      var ata = list[i].userId;

      converDate.add(DateFormat('dd-MM-yyyy').parse(list[i].date.toString()));

      var mapp = {
        'userId': list[i].userId.toString(),
        'name': list[i].userName.toString(),
        'surname': list[i].userSurName.toString(),
        'address': list[i].userAddress.toString(),
        'phoneNumber': list[i].userPhoneNumber.toString(),
        'requestStatus': list[i].requestStatus.toString(),
        //'date': list[i].date.toString(),
        'date': converDate[i],
        'day': list[i].day.toString(),
      };

      liste.add(mapp);
    }
    liste.sort((a, b) => (a['date']!).compareTo(b['date']!));
    //print(liste[3]['date']);
    return liste;
  }

  @override
  Widget build(BuildContext context) {
    final AddressGotoModel _model = AddressGotoModel();
    return AdminPageViewSetting(
      child: ChangeNotifierProvider<AddressGotoModel>(
        create: (_) => AddressGotoModel(),
        builder: (context, child) => Scaffold(
          body: Center(
              child: Column(
            children: [
              StreamBuilder<List<UsersToGo>>(
                stream: Provider.of<AddressGotoModel>(context, listen: false)
                    .getAddressGotoInformation(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<UsersToGo>> asyncSnapshot) {
                  if (asyncSnapshot.hasError) {
                    return const Center(
                      child: Text('hata oluştu'),
                    );
                  } else {
                    if (!asyncSnapshot.hasData) {
                      return const CircularProgressIndicator();
                    } else {
                      var dateList = asyncSnapshot.data;

                      var iterableList = listConvertIterable(dateList);
                      var groupList =
                          groupBy(iterableList, (Map obj) => obj['date'])
                              .values
                              .toList();
                      //print(groupList);
                      print(groupList.length);

                      return Flexible(
                        child: ListView.builder(
                          itemCount: groupList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              color: kBackGroundColor.withAlpha(200),
                              child: ExpansionTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        (groupList[index][0]['date'].toString())
                                                .split(' ')[0] +
                                            "\t\t" +
                                            groupList[index][0]['day']
                                                .toString(),
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                kPrimaryColor.withAlpha(200)),
                                        child: Center(
                                            child: Text(
                                          groupList[index].length.toString(),
                                          textScaleFactor: 0.9,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )),
                                      ),
                                    ],
                                  ),
                                  children: [
                                    expansionTileFunction(index, groupList)
                                  ]),
                            );
                          },
                        ),
                      );
                    }
                  }
                },
              )
            ],
          )),
        ),
      ),
    );
  }

  expansionTileFunction(
      int ustIndex, List<List<Map<String, dynamic>>> degerler) {
    Map<int, Map<String, dynamic>> yeniListe = {};

    final DateModel _dateModel = DateModel();
    int i = 0;
    for (i = 0; i < degerler[ustIndex].length; i++) {
      yeniListe[i] = degerler[ustIndex][i];
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: yeniListe.length,
      itemBuilder: (BuildContext context, int index) {
        return ApplicationMyCard(
          txtName: yeniListe[index]!['name'],
          txtAddress: yeniListe[index]!['address'],
          txtPhoneNumber: yeniListe[index]!['phoneNumber'],
          txtDate: (yeniListe[index]!['date'].toString()).split(' ')[0],
          /*txtName: Users.names[index],
          txtAddress: Users.address[index],
          txtPhoneNumber: Users.phones[index],
          txtDate: Users.date[index], //burası*/
          trallingWidgetMid: CardButton(
            buttonIcon: Icons.assignment_turned_in_outlined,
            buttonText: 'Gidildi',
            iconColor: Colors.green,
            onTapCardButton: () {
              //listeden kaldır veritabanından sil
              //print(lastMap.values);
              //print(degerler);

              _dateModel.deleteRequest(yeniListe[index]!['userId'].toString());

              // //print("uzunluk: ${yeniListe.length}");
              //print('isim: ${yeniListe[index]!['name']} index: $index');

              print('isim: ${yeniListe[index]!} index: $index');

              //print(yeniListe[index]!['name'].toString());

              //print(degerler[1]);
            },
          ),
          trallingWidgetBottom: CardButton(
            buttonIcon: Icons.cancel,
            buttonText: 'İptal et',
            iconColor: Colors.red,
            onTapCardButton: () {
              _dateModel.deleteRequest(yeniListe[index]!['userId'].toString());
            },
          ),
        );
      },
    );
  }
}




/*












class ExpansionTileBuilder extends StatefulWidget {
  final List<List<Map<String, String>>> degerler;
  final int ustIndex;
  const ExpansionTileBuilder({
    Key? key,
    required this.degerler,
    required this.ustIndex,
  }) : super(key: key);

  @override
  State<ExpansionTileBuilder> createState() => _ExpansionTileBuilderState();
}

class _ExpansionTileBuilderState extends State<ExpansionTileBuilder> {
  AddressGotoModel _model = AddressGotoModel();

  Map<int, Map<String, String>> yeniListe = {};
  //var x=Provider<AddressToGo>(create: (BuildContext context) => AddressToGo());

  @override
  void initState() {
    super.initState();
    int i = 0;
    for (i = 0; i < widget.degerler[widget.ustIndex].length; i++) {
      yeniListe[i] = widget.degerler[widget.ustIndex][i];
    }
    //print(yeniListe);
    //yeniListe.clear();
    print('inatState');
  }

  @override
  Widget build(BuildContext context) {
    final DateModel _dateModel = DateModel();
    int i = 0;
    for (i = 0; i < widget.degerler[widget.ustIndex].length; i++) {
      yeniListe[i] = widget.degerler[widget.ustIndex][i];
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: yeniListe.length,
      itemBuilder: (BuildContext context, int index) {
        return ApplicationMyCard(
          txtName: yeniListe[index]!['name'],
          txtAddress: yeniListe[index]!['address'],
          txtPhoneNumber: yeniListe[index]!['phoneNumber'],
          txtDate: yeniListe[index]!['date'],
          /*txtName: Users.names[index],
          txtAddress: Users.address[index],
          txtPhoneNumber: Users.phones[index],
          txtDate: Users.date[index], //burası*/
          trallingWidgetMid: CardButton(
            buttonIcon: Icons.assignment_turned_in_outlined,
            buttonText: 'Gidildi',
            iconColor: Colors.green,
            onTapCardButton: () {
              //listeden kaldır veritabanından sil
              //print(lastMap.values);
              //print(degerler);
              setState(() {
                _dateModel
                    .deleteRequest(yeniListe[index]!['userId'].toString());

                // //print("uzunluk: ${yeniListe.length}");
                print('isim: ${yeniListe[index]!['name']} index: $index');
                //print(yeniListe[index]!['name'].toString());
              });
              //print(degerler[1]);
            },
          ),
          trallingWidgetBottom: CardButton(
            buttonIcon: Icons.cancel,
            buttonText: 'İptal et',
            iconColor: Colors.red,
            onTapCardButton: () {
              //listeden kaldır veritabanından sil bildirim gönder
            },
          ),
        );
      },
    );
  }
}
*/
//16.05.2022
/*

class AddressToGo extends StatelessWidget {
  const AddressToGo({Key? key}) : super(key: key);

  List<Map<String, String>> listConvertIterable(List<UsersToGo>? list) {
    List<Map<String, String>> liste = [];

    liste.clear();
    for (int i = 0; i < list!.length; i++) {
      var ata = list[i].userId;
      var mapp = {
        'userId': list[i].userId.toString(),
        'name': list[i].userName.toString(),
        'surname': list[i].userSurName.toString(),
        'address': list[i].userAddress.toString(),
        'phoneNumber': list[i].userPhoneNumber.toString(),
        'requestStatus': list[i].requestStatus.toString(),
        'date': list[i].date.toString(),
        'day': list[i].day.toString(),
      };

      liste.add(mapp);
      //print(liste.length);
    }
    return liste;
  }

  @override
  Widget build(BuildContext context) {
    final AddressGotoModel _model = AddressGotoModel();
    return AdminPageViewSetting(
      child: ChangeNotifierProvider<AddressGotoModel>(
        create: (_) => AddressGotoModel(),
        builder: (context, child) => Scaffold(
          body: Center(
              child: Column(
            children: [
              StreamBuilder<List<UsersToGo>>(
                stream: Provider.of<AddressGotoModel>(context, listen: false)
                    .getAddressGotoInformation(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<UsersToGo>> asyncSnapshot) {
                  if (asyncSnapshot.hasError) {
                    return const Center(
                      child: Text('hata oluştu'),
                    );
                  } else {
                    if (!asyncSnapshot.hasData) {
                      return const CircularProgressIndicator();
                    } else {
                      var dateList = asyncSnapshot.data;
                      var iterableList = listConvertIterable(dateList);
                      var groupList =
                          groupBy(iterableList, (Map obj) => obj['date'])
                              .values
                              .toList();
                      print(groupList.length);

                      return Flexible(
                        child: ListView.builder(
                          itemCount: groupList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              color: kBackGroundColor.withAlpha(200),
                              child: ExpansionTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        groupList[index][0]['date'].toString(),
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                kPrimaryColor.withAlpha(200)),
                                        child: Center(
                                            child: Text(
                                          groupList[index].length.toString(),
                                          textScaleFactor: 0.9,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )),
                                      ),
                                    ],
                                  ),
                                  children: [
                                    ExpansionTileBuilder(
                                      degerler: groupList,
                                      ustIndex: index,
                                    ),
                                  ]),
                            );
                          },
                        ),
                      );
                    }
                  }
                },
              )
            ],
          )),
        ),
      ),
    );
  }
}

class ExpansionTileBuilder extends StatefulWidget {
  final List<List<Map<String, String>>> degerler;
  final int ustIndex;
  const ExpansionTileBuilder({
    Key? key,
    required this.degerler,
    required this.ustIndex,
  }) : super(key: key);

  @override
  State<ExpansionTileBuilder> createState() => _ExpansionTileBuilderState();
}

class _ExpansionTileBuilderState extends State<ExpansionTileBuilder> {
  AddressGotoModel _model = AddressGotoModel();

  Map<int, Map<String, String>> yeniListe = {};

  @override
  void initState() {
    super.initState();
    int i = 0;
    for (i = 0; i < widget.degerler[widget.ustIndex].length; i++) {
      yeniListe[i] = widget.degerler[widget.ustIndex][i];
    }
    //print(yeniListe);
    //yeniListe.clear();
  }

  void newList() {}

  @override
  Widget build(BuildContext context) {
    final DateModel _dateModel = DateModel();

    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: yeniListe.length,
      itemBuilder: (BuildContext context, int index) {
        return ApplicationMyCard(
          txtName: yeniListe[index]!['name'],
          txtAddress: yeniListe[index]!['address'],
          txtPhoneNumber: yeniListe[index]!['phoneNumber'],
          txtDate: yeniListe[index]!['date'],
          /*txtName: Users.names[index],
          txtAddress: Users.address[index],
          txtPhoneNumber: Users.phones[index],
          txtDate: Users.date[index], //burası*/
          trallingWidgetMid: CardButton(
            buttonIcon: Icons.assignment_turned_in_outlined,
            buttonText: 'Gidildi',
            iconColor: Colors.green,
            onTapCardButton: () {
              //listeden kaldır veritabanından sil
              //print(lastMap.values);
              //print(degerler);
              setState(() {
                _dateModel
                    .deleteRequest(yeniListe[index]!['userId'].toString());

                // //print("uzunluk: ${yeniListe.length}");
                print('isim: ${yeniListe[index]!['name']} index: $index');

                //print(yeniListe[index]!['name'].toString());
              });
              //print(degerler[1]);
            },
          ),
          trallingWidgetBottom: CardButton(
            buttonIcon: Icons.cancel,
            buttonText: 'İptal et',
            iconColor: Colors.red,
            onTapCardButton: () {
              //listeden kaldır veritabanından sil bildirim gönder
            },
          ),
        );
      },
    );
  }
}


*/


/*

Center(
      child: Column(children: [
        FloatingActionButton(onPressed: () {
          //_model.getDate();
        }),
        const Text('slm'),
      ]),
    );
  }

*/

/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seatwashing/components/admin_pages_view_setting.dart';
import 'package:seatwashing/components/application_my_card.dart';
import 'package:seatwashing/components/card_button.dart';
import 'package:seatwashing/models/users.dart';
import 'package:seatwashing/viewmodels/user_request_model.dart';

class UserRequestPage extends StatelessWidget {
  const UserRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UsersRequestModel _model = UsersRequestModel();

    return AdminPageViewSetting(
      child: ChangeNotifierProvider<UsersRequestModel>(
        create: (_) => UsersRequestModel(),
        builder: (context, child) => Scaffold(
          body: Center(
              child: Column(
            children: [
              StreamBuilder<List<Users>>(
                stream: Provider.of<UsersRequestModel>(context, listen: false)
                    .getUsersInformation(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Users>> asyncSnapshot) {
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
                        child: ListView.builder(
                          itemCount: dateList!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ApplicationMyCard(
                              cardLeading: Icons.account_circle,
                              txtPhoneNumber: dateList[index].userPhoneNumber!,
                              txtAddress: dateList[index].userAddress!,
                              txtName: dateList[index].userName! +
                                  " " +
                                  dateList[index].userSurName!,
                              txtDate: '',
                              trallingWidgetBottom: CardButton(
                                buttonIcon: Icons.edit,
                                buttonText: 'Kabul et',
                                iconColor: Colors.green,
                                onTapCardButton: () {
                                  _model.userAdmitIt(
                                      dateList[index].userPhoneNumber!);
                                },
                              ),
                              trallingWidgetMid: const CardButton(
                                buttonIcon: Icons.delete,
                                buttonText: 'Reddet',
                                iconColor: Colors.red,
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }
                },
              )
            ],
          )),
        ),
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   return AdminPageViewSetting(
  //     child: ListView.builder(
  //       itemCount: UsersAttempt.names.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         return ApplicationMyCard(
  //           cardLeading: Icons.account_circle,
  //           txtPhoneNumber: UsersAttempt.phones[index],
  //           txtAddress: UsersAttempt.address[index],
  //           txtName: UsersAttempt.names[index],
  //           txtDate: '',
  //           trallingWidgetBottom: const CardButton(
  //             buttonIcon: Icons.edit,
  //             buttonText: 'Kabul et',
  //             iconColor: Colors.green,
  //           ),
  //           trallingWidgetMid: const CardButton(
  //             buttonIcon: Icons.delete,
  //             buttonText: 'Reddet',
  //             iconColor: Colors.red,
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
}
*/



/*
import "package:collection/collection.dart";
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seatwashing/components/admin_pages_view_setting.dart';
import 'package:seatwashing/components/application_my_card.dart';
import 'package:seatwashing/components/card_button.dart';
import 'package:seatwashing/components/constants.dart';
import 'package:seatwashing/models/users.dart';
import 'package:seatwashing/viewmodels/address_goto_model.dart';

class AddressToGo extends StatefulWidget {
  const AddressToGo({Key? key}) : super(key: key);

  @override
  State<AddressToGo> createState() => _AddressToGoState();
}

class _AddressToGoState extends State<AddressToGo> {
  //Users2 user2 = Users2();
  List<DateTime> date = [];
  Map<dynamic, List<Map<String, String>>> lastMap =
      groupBy(Users2.kisiGoster(), (Map obj) => obj['date']);

  Users2 user2 = Users2();

  var degerler =
      groupBy(Users2.kisiGoster(), (Map obj) => obj['date']).values.toList();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateBuilder();
  }

  void dateBuilder() {
    for (int i = 0; i <= 14; i++) {
      date.add(DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + i));
    }
  }

  String convertDate(DateTime dateTime) {
    var gonder = DateFormat('dd-MM-yyyy').format(dateTime);
    return gonder.toString();
  }
  //ayrı bir expansionTile widget olacak widgeta girilecek değerlere göre widget kendini farklı biçimlerde döndürecek

  @override
  Widget build(BuildContext context) {
    return AdminPageViewSetting(
      child: ListView.builder(
        itemCount: degerler.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: kBackGroundColor.withAlpha(200),
            child: ExpansionTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      degerler[index][0]['date'].toString(),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kPrimaryColor.withAlpha(200)),
                      child: Center(
                          child: Text(
                        degerler[index].length.toString(),
                        textScaleFactor: 0.9,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                    ),
                  ],
                ),
                children: [
                  ExpansionTileBuilder(
                    degerler: degerler,
                    ustIndex: index,
                  ),
                ]),
          );
        },
      ),
    );
  }
}

class ExpansionTileBuilder extends StatefulWidget {
  final List<List<Map<String, String>>> degerler;
  final int ustIndex;
  const ExpansionTileBuilder({
    Key? key,
    required this.degerler,
    required this.ustIndex,
  }) : super(key: key);

  @override
  State<ExpansionTileBuilder> createState() => _ExpansionTileBuilderState();
}

class _ExpansionTileBuilderState extends State<ExpansionTileBuilder> {
  AddressGotoModel _model = AddressGotoModel();

  Map<int, Map<String, String>> yeniListe = {};

  @override
  void initState() {
    super.initState();
    int i = 0;
    for (i = 0; i < widget.degerler[widget.ustIndex].length; i++) {
      yeniListe[i] = widget.degerler[widget.ustIndex][i];
    }
    //print(yeniListe);
    //yeniListe.clear();
  }

  void newList() {}

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: yeniListe.length,
      itemBuilder: (BuildContext context, int index) {
        return ApplicationMyCard(
          txtName: yeniListe[index]!['name'],
          txtAddress: yeniListe[index]!['address'],
          txtPhoneNumber: yeniListe[index]!['phones'],
          txtDate: yeniListe[index]!['date'],
          /*txtName: Users.names[index],
          txtAddress: Users.address[index],
          txtPhoneNumber: Users.phones[index],
          txtDate: Users.date[index], //burası*/
          trallingWidgetMid: CardButton(
            buttonIcon: Icons.assignment_turned_in_outlined,
            buttonText: 'Gidildi',
            iconColor: Colors.green,
            onTapCardButton: () {
              //listeden kaldır veritabanından sil
              //print(lastMap.values);
              //print(degerler);

              setState(() {
                _model.getDate();
              });
              //print(degerler[1]);
            },
          ),
          trallingWidgetBottom: CardButton(
            buttonIcon: Icons.cancel,
            buttonText: 'İptal et',
            iconColor: Colors.red,
            onTapCardButton: () {
              //listeden kaldır veritabanından sil bildirim gönder
            },
          ),
        );
      },
    );
  }
}
*/


/*
































// import "package:collection/collection.dart";
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:seatwashing/components/admin_pages_view_setting.dart';
// import 'package:seatwashing/components/application_my_card.dart';
// import 'package:seatwashing/components/card_button.dart';
// import 'package:seatwashing/components/constants.dart';
// import 'package:seatwashing/models/users.dart';
// import 'package:seatwashing/viewmodels/address_goto_model.dart';

// class AddressToGo extends StatefulWidget {
//   const AddressToGo({Key? key}) : super(key: key);

//   @override
//   State<AddressToGo> createState() => _AddressToGoState();
// }

// class _AddressToGoState extends State<AddressToGo> {
//   //Users2 user2 = Users2();
//   AddressGotoModel _gotoModel = AddressGotoModel();
//   List<DateTime> date = [];
//   Map<dynamic, List<Map<String, String>>> lastMap =
//       groupBy(Users2.kisiGoster(), (Map obj) => obj['date']);

//   Users2 user2 = Users2();

//   // var degerler =
//   //     groupBy(Users2.kisiGoster(), (Map obj) => obj['date']).values.toList();

//   List<List<Map<String, dynamic>>> degerler = [];

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     dateBuilder();
//     verial();
//   }

//   verial() async {
//     degerler = await _gotoModel.getDate();
//     print(degerler.length);
//   }

//   void dateBuilder() {
//     for (int i = 0; i <= 14; i++) {
//       date.add(DateTime(
//           DateTime.now().year, DateTime.now().month, DateTime.now().day + i));
//     }
//   }

//   String convertDate(DateTime dateTime) {
//     var gonder = DateFormat('dd-MM-yyyy').format(dateTime);
//     return gonder.toString();
//   }
//   //ayrı bir expansionTile widget olacak widgeta girilecek değerlere göre widget kendini farklı biçimlerde döndürecek

//   @override
//   Widget build(BuildContext context) {
//     return AdminPageViewSetting(
//       child: ListView.builder(
//         itemCount: degerler.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Card(
//             color: kBackGroundColor.withAlpha(200),
//             child: ExpansionTile(
//                 title: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       degerler[index][0]['date'].toString(),
//                       style: const TextStyle(
//                         fontSize: 18,
//                       ),
//                     ),
//                     Container(
//                       width: 25,
//                       height: 25,
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: kPrimaryColor.withAlpha(200)),
//                       child: Center(
//                           child: Text(
//                         degerler[index].length.toString(),
//                         textScaleFactor: 0.9,
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, color: Colors.white),
//                       )),
//                     ),
//                   ],
//                 ),
//                 children: [
//                   // ExpansionTileBuilder(
//                   //   degerler: degerler,
//                   //   ustIndex: index,
//                   // ),
//                 ]),
//           );
//         },
//       ),
//     );
//   }
// }

// class ExpansionTileBuilder extends StatefulWidget {
//   final List<List<Map<String, String>>> degerler;
//   final int ustIndex;
//   const ExpansionTileBuilder({
//     Key? key,
//     required this.degerler,
//     required this.ustIndex,
//   }) : super(key: key);

//   @override
//   State<ExpansionTileBuilder> createState() => _ExpansionTileBuilderState();
// }

// class _ExpansionTileBuilderState extends State<ExpansionTileBuilder> {
//   Map<int, Map<String, String>> yeniListe = {};

//   @override
//   void initState() {
//     super.initState();
//     int i = 0;
//     for (i = 0; i < widget.degerler[widget.ustIndex].length; i++) {
//       yeniListe[i] = widget.degerler[widget.ustIndex][i];
//     }
//     //print(yeniListe);
//     //yeniListe.clear();
//   }

//   void newList() {}

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const ClampingScrollPhysics(),
//       itemCount: yeniListe.length,
//       itemBuilder: (BuildContext context, int index) {
//         return ApplicationMyCard(
//           txtName: yeniListe[index]!['names'],
//           txtAddress: yeniListe[index]!['address'],
//           txtPhoneNumber: yeniListe[index]!['phones'],
//           txtDate: yeniListe[index]!['date'],
//           /*txtName: Users.names[index],
//           txtAddress: Users.address[index],
//           txtPhoneNumber: Users.phones[index],
//           txtDate: Users.date[index], //burası*/
//           trallingWidgetMid: CardButton(
//             buttonIcon: Icons.assignment_turned_in_outlined,
//             buttonText: 'Gidildi',
//             iconColor: Colors.green,
//             onTapCardButton: () {
//               //listeden kaldır veritabanından sil
//               //print(lastMap.values);
//               //print(degerler);
//               print(yeniListe.length);
//               //print(degerler[1]);
//             },
//           ),
//           trallingWidgetBottom: CardButton(
//             buttonIcon: Icons.cancel,
//             buttonText: 'İptal et',
//             iconColor: Colors.red,
//             onTapCardButton: () {
//               //listeden kaldır veritabanından sil bildirim gönder
//             },
//           ),
//         );
//       },
//     );
//   }
// }

// class AddressToGo extends StatefulWidget {
//   const AddressToGo({Key? key}) : super(key: key);

//   @override
//   State<AddressToGo> createState() => _AddressToGoState();
// }

// class _AddressToGoState extends State<AddressToGo> {
//   //Users2 user2 = Users2();
//   List<DateTime> date = [];
//   Map<dynamic, List<Map<String, String>>> lastMap =
//       groupBy(Users2.kisiGoster(), (Map obj) => obj['date']);

//   Users2 user2 = Users2();

//   var degerler =
//       groupBy(Users2.kisiGoster(), (Map obj) => obj['date']).values.toList();

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     dateBuilder();
//   }

//   void dateBuilder() {
//     for (int i = 0; i <= 14; i++) {
//       date.add(DateTime(
//           DateTime.now().year, DateTime.now().month, DateTime.now().day + i));
//     }
//   }

//   String convertDate(DateTime dateTime) {
//     var gonder = DateFormat('dd-MM-yyyy').format(dateTime);
//     return gonder.toString();
//   }
//   //ayrı bir expansionTile widget olacak widgeta girilecek değerlere göre widget kendini farklı biçimlerde döndürecek

//   @override
//   Widget build(BuildContext context) {
//     return AdminPageViewSetting(
//       child: ListView.builder(
//         itemCount: degerler.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Card(
//             color: kBackGroundColor.withAlpha(200),
//             child: ExpansionTile(
//                 title: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       degerler[index][0]['date'].toString(),
//                       style: const TextStyle(
//                         fontSize: 18,
//                       ),
//                     ),
//                     Container(
//                       width: 25,
//                       height: 25,
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: kPrimaryColor.withAlpha(200)),
//                       child: Center(
//                           child: Text(
//                         degerler[index].length.toString(),
//                         textScaleFactor: 0.9,
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, color: Colors.white),
//                       )),
//                     ),
//                   ],
//                 ),
//                 children: [
//                   // ExpansionTileBuilder(
//                   //   degerler: degerler,
//                   //   ustIndex: index,
//                   // ),
//                 ]),
//           );
//         },
//       ),
//     );
//   }
// }

// class ExpansionTileBuilder extends StatefulWidget {
//   final List<List<Map<String, String>>> degerler;
//   final int ustIndex;
//   const ExpansionTileBuilder({
//     Key? key,
//     required this.degerler,
//     required this.ustIndex,
//   }) : super(key: key);

//   @override
//   State<ExpansionTileBuilder> createState() => _ExpansionTileBuilderState();
// }

// class _ExpansionTileBuilderState extends State<ExpansionTileBuilder> {
//   Map<int, Map<String, String>> yeniListe = {};

//   @override
//   void initState() {
//     super.initState();
//     int i = 0;
//     for (i = 0; i < widget.degerler[widget.ustIndex].length; i++) {
//       yeniListe[i] = widget.degerler[widget.ustIndex][i];
//     }
//     //print(yeniListe);
//     //yeniListe.clear();
//   }

//   void newList() {}

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const ClampingScrollPhysics(),
//       itemCount: yeniListe.length,
//       itemBuilder: (BuildContext context, int index) {
//         return ApplicationMyCard(
//           txtName: yeniListe[index]!['names'],
//           txtAddress: yeniListe[index]!['address'],
//           txtPhoneNumber: yeniListe[index]!['phones'],
//           txtDate: yeniListe[index]!['date'],
//           /*txtName: Users.names[index],
//           txtAddress: Users.address[index],
//           txtPhoneNumber: Users.phones[index],
//           txtDate: Users.date[index], //burası*/
//           trallingWidgetMid: CardButton(
//             buttonIcon: Icons.assignment_turned_in_outlined,
//             buttonText: 'Gidildi',
//             iconColor: Colors.green,
//             onTapCardButton: () {
//               //listeden kaldır veritabanından sil
//               //print(lastMap.values);
//               //print(degerler);
//               print(yeniListe.length);
//               //print(degerler[1]);
//             },
//           ),
//           trallingWidgetBottom: CardButton(
//             buttonIcon: Icons.cancel,
//             buttonText: 'İptal et',
//             iconColor: Colors.red,
//             onTapCardButton: () {
//               //listeden kaldır veritabanından sil bildirim gönder
//             },
//           ),
//         );
//       },
//     );
//   }
// }











*/
/*10.02.2022-20:46
import "package:collection/collection.dart";
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seatwashing/components/admin_pages_view_setting.dart';
import 'package:seatwashing/components/application_my_card.dart';
import 'package:seatwashing/components/card_button.dart';
import 'package:seatwashing/components/constants.dart';
import 'package:seatwashing/models/users.dart';

class AddressToGo extends StatefulWidget {
  const AddressToGo({Key? key}) : super(key: key);

  @override
  State<AddressToGo> createState() => _AddressToGoState();
}

class _AddressToGoState extends State<AddressToGo> {
  //Users2 user2 = Users2();
  List<DateTime> date = [];
  Map<dynamic, List<Map<String, String>>> lastMap =
      groupBy(Users2.kisiGoster(), (Map obj) => obj['date']);
  Users2 user2 = Users2();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateBuilder();
  }

  void dateBuilder() {
    for (int i = 0; i <= 14; i++) {
      date.add(DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + i));
    }
  }

  String convertDate(DateTime dateTime) {
    var gonder = DateFormat('dd-MM-yyyy').format(dateTime);
    return gonder.toString();
  }

  @override
  Widget build(BuildContext context) {
    return AdminPageViewSetting(
      child: ListView.builder(
        itemCount: lastMap.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: kBackGroundColor.withAlpha(200),
            child:
                ExpansionTile(title: Text(convertDate(date[index])), children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: Users.names.length,
                itemBuilder: (BuildContext context, int index) {
                  return ApplicationMyCard(
                    txtName: Users.names[index],
                    txtAddress: Users.address[index],
                    txtPhoneNumber: Users.phones[index],
                    txtDate: Users.date[index], //burası
                    trallingWidgetMid: CardButton(
                      buttonIcon: Icons.assignment_turned_in_outlined,
                      buttonText: 'Gidildi',
                      iconColor: Colors.green,
                      onTapCardButton: () {
                        //listeden kaldır veritabanından sil
                        print(lastMap.keys);
                      },
                    ),
                    trallingWidgetBottom: CardButton(
                      buttonIcon: Icons.cancel,
                      buttonText: 'İptal et',
                      iconColor: Colors.red,
                      onTapCardButton: () {
                        //listeden kaldır veritabanından sil bildirim gönder
                      },
                    ),
                  );
                },
              ),
            ]),
          );
        },
      ),
    );
  }
}

10.02.2022-20:46*/

/*ApplicationMyCard(
            txtName: Users.names[index],
            txtAddress: Users.address[index],
            txtPhoneNumber: Users.phones[index],
            txtDate: Users.date[index],
            trallingWidgetMid: CardButton(
              buttonIcon: Icons.assignment_turned_in_outlined,
              buttonText: 'Gidildi',
              iconColor: Colors.green,
              onTapCardButton: () {
                //listeden kaldır veritabanından sil
              },
            ),
            trallingWidgetBottom: CardButton(
              buttonIcon: Icons.cancel,
              buttonText: 'İptal et',
              iconColor: Colors.red,
              onTapCardButton: () {
                //listeden kaldır veritabanından sil bildirim gönder
              },
            ),
          ); */

/*Widget build(BuildContext context) {
    String dropdownValue = 'One';
    return AdminPageViewSetting(
      child: ListView.builder(
        itemCount: Users.names.length,
        itemBuilder: (BuildContext context, int index) {
          return ApplicationMyCard(
            txtName: Users.names[index],
            txtAddress: Users.address[index],
            txtPhoneNumber: Users.phones[index],
            txtDate: Users.date[index],
            trallingWidgetMid: CardButton(
              buttonIcon: Icons.assignment_turned_in_outlined,
              buttonText: 'Gidildi',
              iconColor: Colors.green,
              onTapCardButton: () {
                //listeden kaldır veritabanından sil
              },
            ),
            trallingWidgetBottom: CardButton(
              buttonIcon: Icons.cancel,
              buttonText: 'İptal et',
              iconColor: Colors.red,
              onTapCardButton: () {
                //listeden kaldır veritabanından sil bildirim gönder
              },
            ),
          );
        },
      ),
    );
  }*/
