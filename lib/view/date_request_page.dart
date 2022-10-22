import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seatwashing/components/admin_pages_view_setting.dart';
import 'package:seatwashing/components/application_my_card.dart';
import 'package:seatwashing/components/card_button.dart';
import 'package:seatwashing/models/daterequest.dart';
import 'package:seatwashing/viewmodels/date_request_model.dart';

class DateRequestPage extends StatefulWidget {
  const DateRequestPage({Key? key}) : super(key: key);

  @override
  State<DateRequestPage> createState() => _DateRequestPageState();
}

class _DateRequestPageState extends State<DateRequestPage> {
  @override
  Widget build(BuildContext context) {
    final DateRequestModel _model = DateRequestModel();

    return AdminPageViewSetting(
      child: ChangeNotifierProvider<DateRequestModel>(
        create: (_) => DateRequestModel(),
        builder: (context, child) => Scaffold(
          body: Center(
            child: Column(
              children: [
                StreamBuilder<List<DateRequest>>(
                  stream: Provider.of<DateRequestModel>(context, listen: false)
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
                          child: ListView.builder(
                            itemCount: dateList!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ApplicationMyCard(
                                txtName: dateList[index].userName! +
                                    " " +
                                    dateList[index].userSurName!,
                                txtAddress: dateList[index].userAddress!,
                                txtPhoneNumber:
                                    dateList[index].userPhoneNumber!,
                                txtDate: dateList[index].date!,
                                trallingWidgetMid: CardButton(
                                  buttonIcon: Icons.cancel,
                                  buttonText: 'İptal et',
                                  iconColor: Colors.red,
                                  onTapCardButton: () {
                                    print('ohara ohara');
                                    _model
                                        .deleteRequest(dateList[index].userId!);
                                  },
                                ),
                                trallingWidgetBottom: CardButton(
                                  buttonIcon: Icons.done,
                                  buttonText: 'Onayla',
                                  iconColor: Colors.green,
                                  onTapCardButton: () {
                                    //print("ohara!");
                                    _model.dateRequestAdmitIt(
                                        dateList[index].userId!);
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
            ),
          ),
        ),
      ),
    );
  }
}




/// YEDEK İLK///
// class DateRequestPage extends StatelessWidget {
//   const DateRequestPage({Key? key}) : super(key: key);
//   final int i = 5;
//   @override
//   Widget build(BuildContext context) {
//     final DateRequestModel _model = DateRequestModel();

//     return AdminPageViewSetting(
//       child: ListView.builder(
//         itemCount: UsersAttempt.names.length,
//         itemBuilder: (BuildContext context, int index) {
//           return ApplicationMyCard(
//             txtName: UsersAttempt.names[index],
//             txtAddress: UsersAttempt.address[index],
//             txtPhoneNumber: UsersAttempt.phones[index],
//             txtDate: UsersAttempt.date[index],
//             trallingWidgetMid: const CardButton(
//               buttonIcon: Icons.cancel,
//               buttonText: 'İptal et',
//               iconColor: Colors.red,
//             ),
//             trallingWidgetBottom: CardButton(
//               buttonIcon: Icons.done,
//               buttonText: 'Onayla',
//               iconColor: Colors.green,
//               onTapCardButton: () {
//                 _model.getDateRequestInformation();
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

/// YEDEK 2
// class DateRequestPage extends StatefulWidget {
//   const DateRequestPage({Key? key}) : super(key: key);

//   @override
//   State<DateRequestPage> createState() => _DateRequestPageState();
// }

// class _DateRequestPageState extends State<DateRequestPage> {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<DateRequestModel>(
//       create: (_) => DateRequestModel(),
//       builder: (context, child) => Scaffold(
//         appBar: AppBar(title: const Text('RANDEVU İSTEKLERİ')),
//         body: Center(
//             child: Column(
//           children: [
//             StreamBuilder<List<DateRequest>>(
//               stream: Provider.of<DateRequestModel>(context, listen: false)
//                   .getDateRequestInformation(),
//               builder: (BuildContext context,
//                   AsyncSnapshot<List<DateRequest>> asyncSnapshot) {
//                 if (asyncSnapshot.hasError) {
//                   print("HATA!!");
//                   print(asyncSnapshot.error);
//                   return const Center(
//                     child: Text('hata oluştu'),
//                   );
//                 } else {
//                   if (!asyncSnapshot.hasData) {
//                     return const CircularProgressIndicator();
//                   } else {
//                     var dateList = asyncSnapshot.data;
//                     return Flexible(
//                       child: ListView.builder(
//                           itemCount: dateList!.length,
//                           itemBuilder: (context, index) {
//                             return Dismissible(
//                               key: UniqueKey(),
//                               direction: DismissDirection.endToStart,
//                               background: Container(
//                                 alignment: Alignment.centerRight,
//                                 child: const Icon(
//                                   Icons.delete,
//                                   color: Colors.white,
//                                 ),
//                                 color: Colors.redAccent,
//                               ),
//                               onDismissed: (_) => {},
//                               child: Card(
//                                 child: ListTile(
//                                   title: Text(dateList[index].userName!),
//                                   subtitle:
//                                       Text(dateList[index].userPhoneNumber!),
//                                 ),
//                               ),
//                             );
//                           }),
//                     );
//                   }
//                 }
//               },
//             )
//           ],
//         )),
//       ),
//     );
//   }
// }