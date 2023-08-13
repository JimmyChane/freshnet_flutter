import 'package:flutter/material.dart';

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
