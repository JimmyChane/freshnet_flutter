import 'package:flutter/material.dart';
import 'dart:core';

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
