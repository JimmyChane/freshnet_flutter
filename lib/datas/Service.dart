import 'dart:convert';

import 'package:freshnet_flutter/datas/Belonging.dart';
import 'package:freshnet_flutter/datas/Customer.dart';
import 'package:freshnet_flutter/datas/Event.dart';
import 'package:freshnet_flutter/datas/Image.dart';
import 'package:freshnet_flutter/datas/Label.dart';
import 'package:freshnet_flutter/datas/State.dart';
import 'package:freshnet_flutter/datas/Timestamp.dart';
import 'package:freshnet_flutter/logics/Api.dart';
import 'package:freshnet_flutter/logics/Login.dart';
import 'package:http/http.dart' as http;

class Service {
  static Future<List<Service>?> getList() async {
    String? token = await Login.getLocalToken();

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

    return jsonServices.map((e) => Service().fromData(e)).toList();
  }

  static Future<Service> add() async {
    throw Error();
  }

  String id = '';
  Timestamp? timestamp;
  String description = '';
  String username = '';
  String name = '';
  ServiceState state = ServiceState.PENDING;
  Customer? customer;
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

  Future<Service> updateState(ServiceState? state) async {
    String? token = await Login.getLocalToken();

    if (token == null) {
      return this;
    }
    if (state == null) {
      this.state = ServiceState.PENDING;
      return this;
    }

    final response = await http.put(
      Uri.parse('${Api.HOST}/service_v2/item/$id/update/state/'),
      headers: {
        'Content-Type': 'application/json',
        'authorization': token,
      },
      body: jsonEncode({'content': state.key}),
    );

    if (response.statusCode != 200) {
      print('request failed');
      return this;
    }

    this.state = state;
    return this;
  }

  Future<Service> delete() async {
    String? token = await Login.getLocalToken();

    if (token == null) {
      return this;
    }

    final response = await http.delete(
      Uri.parse('${Api.HOST}/service_v2/delete/item/$id'),
      headers: {
        'Content-Type': 'application/json',
        'authorization': token,
      },
    );

    if (response.statusCode != 200) {
      print('request failed');
      return this;
    }

    return this;
  }
}
