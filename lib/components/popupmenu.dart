// import 'package:flutter/material.dart';
// import 'package:seatwashing/view/admin_page.dart';
// import 'package:seatwashing/view/adress_to_go_page.dart';
// import 'package:seatwashing/view/date_page.dart';
// import 'package:seatwashing/view/sign_in_page.dart';

// class PopUpMenu extends StatelessWidget {
//   const PopUpMenu({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton<MenuItem>(
//       onSelected: (item) {
//         onSelected(context, item);
//       },
//       itemBuilder: (context) =>
//           [...MenuItems.firsItems.map(buildItem).toList()],
//     );
//   }

//   PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem(
//         value: item,
//         child: Row(
//           children: [
//             Icon(
//               item.icon,
//               color: Colors.black,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(item.text),
//             ),
//           ],
//         ),
//       );
// }

// @override
// void onSelected(BuildContext context, MenuItem item) {
//   switch (item) {
//     case MenuItems.itemDateRequest:
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const DatePage()),
//       );
//       break;
//     case MenuItems.itemAdress:
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => AddressToGo()),
//       );
//       break;
//     case MenuItems.itemUser:
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const SignInPage()),
//       );
//       break;
//     case MenuItems.itemUserRequest:
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const SignInPage()),
//       );
//       break;
//   }
// }
