import 'package:flutter/material.dart';
import 'package:seatwashing/components/card_button.dart';

class UserCard extends StatelessWidget {
  final String txtName;
  final String txtPhone;
  final String txAddress;
  final Widget? trallingWidget;

  const UserCard(
      {Key? key,
      required this.txtName,
      required this.txtPhone,
      required this.txAddress,
      this.trallingWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: ListTile(
          leading: const Icon(
            Icons.supervised_user_circle,
            size: 45.0,
          ),
          title: const Text('saas'),
          subtitle: Column(
            children: [
              Text(txtName),
              Text(txtName),
              Text(txtName),
              Text(txtName),
              Text(txtName),
            ],
          ),
          trailing: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CardButton(
                    buttonIcon: Icons.done,
                    buttonText: 'Kabul et',
                    iconColor: Colors.green),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CardButton(
                    buttonIcon: Icons.cancel,
                    buttonText: 'Reddet',
                    iconColor: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
