import 'package:flutter/material.dart';

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
