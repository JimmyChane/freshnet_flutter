import 'package:freshnet_flutter/datas/PhoneNumber.dart';

class Customer {
  String name = '';
  PhoneNumber? phoneNumber = null;

  fromData(data) {
    name = data['name'];
    phoneNumber = data['phoneNumber'] is String
        ? PhoneNumber().fromData(data['phoneNumber'])
        : null;

    return this;
  }
}
