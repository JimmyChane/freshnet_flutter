import 'dart:convert';
import 'dart:core';
import 'dart:typed_data';

import 'package:freshnet_flutter/Api.dart';
import 'package:freshnet_flutter/Token.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class Services {
  static Future<List<Service>?> getList() async {
    String? token = await Token.get();

    if (token == null) return null;

    final response = await http.get(
      Uri.parse('${Api.HOST}/service_v2/get/items/'),
      headers: {'authorization': token},
    );
    if (response.statusCode != 200) {
      print('request failed');
      return null;
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    final List<dynamic> jsonServices = data['content'];

    List<Service> list = [];
    for (var jsonService in jsonServices) {
      list.add(Service().fromData(jsonService));
    }

    return list;
  }
}

class Service {
  String id = '';
  Timestamp? timestamp = null;
  String description = '';
  String username = '';
  String name = '';
  ServiceState state = ServiceState.PENDING;
  Customer? customer = null;
  List<Belonging> belongings = [];
  List<ServiceEvent> events = [];
  List<ServiceImage> images = [];
  List<ServiceLabel> labels = [];

  Service();

  Service fromData(data) {
    id = data['_id'];
    timestamp = data['time'] is int ? Timestamp(data['time']) : null;
    customer = Customer().fromData(data['customer']);
    description = data['description'] ?? '';
    username = data['username'] ?? '';
    name = data['name'] ?? '';

    if (data['state'] == ServiceState.WAITING.key) {
      state = ServiceState.WAITING;
    } else if (data['state'] == ServiceState.COMPLETED.key) {
      state = ServiceState.COMPLETED;
    } else if (data['state'] == ServiceState.REJECTED.key) {
      state = ServiceState.REJECTED;
    } else {
      state = ServiceState.PENDING;
    }

    belongings = [];
    if (data['belongings'] is List) {
      List belongings = data['belongings'];

      for (var belonging in belongings) {
        this.belongings.add(Belonging().fromData(belonging));
      }
    }

    events = [];
    if (data['events'] is List) {
      List events = data['events'];

      for (var event in events) {
        this.events.add(ServiceEvent().fromData(event));
      }
    }

    var noticeUrgent = data['notice']?['isUrgent'] ?? false;
    var noticeWarranty = data['notice']?['isWarranty'] ?? false;

    labels = [];
    if (data['labels'] is List) {
      List labels = data['labels'];

      var urgent = labels.firstWhere((label) {
        return label['title'] == ServiceLabel.URGENT.title;
      }, orElse: () => null);
      var warranty = labels.firstWhere(
          (label) => label['title'] == ServiceLabel.WARRANTY.title,
          orElse: () => null);

      if (noticeUrgent && urgent != null) {
        this.labels.add(ServiceLabel.URGENT);
      }
      if (noticeWarranty && warranty != null) {
        this.labels.add(ServiceLabel.WARRANTY);
      }
    }

    images = [];
    if (data['imageFiles'] is List) {
      for (var imageFile in data['imageFiles']) {
        images.add(ServiceImage().fromData(imageFile));
      }
    }

    return this;
  }
}

class ServiceImage {
  String name = '';
  String path = '';
  String method = '';
  String storageType = '';

  fromData(data) {
    name = data['name'];
    path = data['path'];
    method = data['method'];
    storageType = data['storageType'];

    return this;
  }

  Future<Uint8List> toBlob() async {
    const String apiUrl = 'http://localhost/service_v2/get/image';
    final String url = '$apiUrl/$name';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to fetch Blob data');
    }
  }
}

class Timestamp {
  final int time;
  late final DateTime date;

  Timestamp(this.time) {
    date = DateTime.fromMillisecondsSinceEpoch(time);
  }

  @override
  toString() {
    return date.toString();
  }
}

class ServiceLabel {
  static ServiceLabel URGENT = const ServiceLabel(
    title: 'Urgent',
    color: Color(0xFFD93F35),
  );
  static ServiceLabel WARRANTY = const ServiceLabel(
    title: 'Warranty',
    color: Color(0xFFDB950C),
  );

  final String title;
  final Color color;

  const ServiceLabel({required this.title, required this.color});
}

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

class Method {
  static final Method INFO = Method(
    key: 'info',
    title: 'Info',
    color: const Color(0xFF0771D2),
  );
  static final Method QUOTATION = Method(
    key: 'quotation',
    title: 'Quotation',
    color: const Color(0xFF961D96),
  );
  static final Method PURCHASE = Method(
    key: 'purchase',
    title: 'Purchase',
    color: const Color(0xFF258915),
  );

  final String key;
  final String title;
  final Color color;

  Method({required this.key, required this.title, required this.color});
}

class Belonging {
  String title = '';
  int time = 0;
  int quantity = 1;
  String description = '';

  fromData(data) {
    title = data['title'];
    time = data['time'];
    quantity = data['quantity'];
    description = data['description'];

    return this;
  }
}

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

class PhoneNumber {
  String value = '';

  fromData(data) {
    value = data;

    return this;
  }

  @override
  String toString() {
    String spliceString(String text, int index, {int count = 1}) {
      if (count <= 0) return text;
      if (index == 0) return text.substring(index + count);
      if (text.length <= index + count) return text.substring(0, index);
      return text.substring(0, index) + text.substring(index + count);
    }

    for (int i = 0; i < value.length; i++) {
      String char = value[i];
      int? number = int.tryParse(char);
      if (number == null) {
        value = spliceString(value, i);
        i--;
      }
    }

    return value;
  }
}

class ServiceState {
  static const ServiceState PENDING = ServiceState(
    'pending',
    'Pending',
    Color(0xFFF4A60D),
  );
  static const ServiceState WAITING = ServiceState(
    'waiting',
    'Waiting for Pickup',
    Color(0xFFC336D9),
  );
  static const ServiceState COMPLETED = ServiceState(
    'completed',
    'Finished & Pickup',
    Color(0xFF25AD86),
  );
  static const ServiceState REJECTED = ServiceState(
    'rejected',
    'Rejected & Pickup',
    Color(0xFFD94136),
  );

  final String key;
  final String title;
  final Color color;

  const ServiceState(this.key, this.title, this.color);
}
