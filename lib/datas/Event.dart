import 'package:freshnet_flutter/datas/Method.dart';
import 'package:freshnet_flutter/datas/Timestamp.dart';

class ServiceEvent {
  Timestamp timestamp = Timestamp(DateTime.now().millisecondsSinceEpoch);
  String username = '';
  String name = '';
  Method method = Method.INFO;
  String description = '';
  String status = '';
  // String? price = null;
  // List<Image> images = [];

  fromData(data) {
    username = data['username'] ?? '';
    name = data['username'] ?? '';
    description = data['description'] ?? '';
    status = data['status'] ?? '';

    if (data['time'] is int) {
      timestamp = Timestamp(data['time']);
    }

    if (data['method'] == Method.QUOTATION.key) {
      method = Method.QUOTATION;
    } else if (data['method'] == Method.PURCHASE.key) {
      method = Method.PURCHASE;
    } else {
      method = Method.INFO;
    }

    return this;
  }
}
