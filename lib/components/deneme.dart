import 'package:flutter/material.dart';
import 'package:seatwashing/viewmodels/address_goto_model.dart';

class DenemeWidget extends StatelessWidget {
  //final AddressGotoModel _model = AddressGotoModel();
  const DenemeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
    );
  }
}
