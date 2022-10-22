import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seatwashing/components/admin_pages_view_setting.dart';
import 'package:seatwashing/components/application_my_card.dart';
import 'package:seatwashing/components/card_button.dart';
import 'package:seatwashing/components/rounded_inputs.dart';
import 'package:seatwashing/components/toast_message.dart';
import 'package:seatwashing/models/users.dart';
import 'package:seatwashing/viewmodels/users_model.dart';

import '../components/rounded_button.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<Map<String, dynamic>> listConvertIterable(List<Users>? list) {
    List<Map<String, dynamic>> liste = [];

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
      };

      liste.add(mapp);
    }
    liste.sort((a, b) => (a['name']!).compareTo(b['name']!));
    //print(liste[3]['date']);
    return liste;
  }

  @override
  Widget build(BuildContext context) {
    final UsersModel _model = UsersModel();

    return AdminPageViewSetting(
      child: ChangeNotifierProvider<UsersModel>(
        create: (_) => UsersModel(),
        builder: (context, child) => Scaffold(
          body: Center(
              child: Column(
            children: [
              StreamBuilder<List<Users>>(
                stream: Provider.of<UsersModel>(context, listen: false)
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
                      var iterableList = listConvertIterable(dateList);

                      return Flexible(
                        child: ListView.builder(
                          itemCount: dateList!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ApplicationMyCard(
                              cardLeading: Icons.account_circle,
                              txtPhoneNumber: iterableList[index]
                                  ['phoneNumber'],
                              txtAddress: iterableList[index]['address'],
                              txtName: iterableList[index]['name'] +
                                  " " +
                                  iterableList[index]['surname'],
                              txtDate: '',
                              trallingWidgetBottom: CardButton(
                                buttonIcon: Icons.edit,
                                buttonText: 'Düzenle',
                                iconColor: Colors.green,
                                onTapCardButton: () {
                                  userEdit(
                                      iterableList[index]['userId'],
                                      iterableList[index]['name'],
                                      iterableList[index]['surname'],
                                      iterableList[index]['phoneNumber'],
                                      iterableList[index]['address'],
                                      _model);
                                },
                              ),
                              trallingWidgetMid: CardButton(
                                buttonIcon: Icons.delete,
                                buttonText: 'Sil',
                                iconColor: Colors.red,
                                onTapCardButton: () {
                                  _model.deleteUser(
                                      iterableList[index]['userId'],
                                      iterableList[index]['phoneNumber']);
                                },
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

  userEdit(String userId, String name, String surname, String phoneNumber,
      String address, UsersModel _model) {
    List<TextEditingController?> controller = [
      TextEditingController(text: name),
      TextEditingController(text: surname),
      TextEditingController(text: phoneNumber),
      TextEditingController(text: address),
    ];

    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Düzenle'),
              content: SingleChildScrollView(
                child: Column(children: [
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
                      size: MediaQuery.of(context).size,
                      buttonName: 'Güncelle',
                      function: () async {
                        print(controller[0]!.text.toString());
                        var durum = await _model.userUpdate(
                          userId,
                          controller[0]!.text.toString(),
                          controller[1]!.text.toString(),
                          controller[2]!.text.toString(),
                          controller[3]!.text.toString(),
                        );
                        if (durum == true) {
                          ToastMessage.ToastMessageShow("Güncellendi");
                          Navigator.of(context, rootNavigator: true).pop();
                        } else {
                          ToastMessage.ToastMessageShow("Hata oluştu");
                        }
                        print('Durum $durum');
                      }),
                ]),
              ),
            ));
  }
}

























/*PopupMenuButton<String>(
                onSelected: (String value) {
                  setState(() {
                    _selection = value;
                  });
                },
                child: ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.add_alarm),
                    onPressed: () {
                      print('Hello world');
                    },
                  ),
                  title: Text('Title'),
                  subtitle: Column(
                    children: <Widget>[
                      Text('Sub title'),
                      Text(_selection == null
                          ? 'Nothing selected yet'
                          : _selection.toString()),
                    ],
                  ),
                  trailing: Icon(Icons.account_circle),
                ),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'Value1',
                    child: Text('Choose value 1'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Value2',
                    child: Text('Choose value 2'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Value3',
                    child: Text('Choose value 3'),
                  ),
                ],
              );*/

/**/
