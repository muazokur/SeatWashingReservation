import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seatwashing/components/application_my_card.dart';
import 'package:seatwashing/models/users.dart';
import 'package:seatwashing/viewmodels/address_goto_model.dart';
import 'package:seatwashing/viewmodels/users_model.dart';
import 'package:collection/src/functions.dart';
import '../components/admin_pages_view_setting.dart';
import '../components/card_button.dart';
import '../components/constants.dart';

class UserRequestPage extends StatelessWidget {
  const UserRequestPage({Key? key}) : super(key: key);

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
