import 'package:flutter/material.dart';

class NotificationCard {
  final String purchaseDate;
  final String drawDate;
  final String prize;
  final String logo;
  final String product;
  final String couponNo;

  const NotificationCard({
    required this.purchaseDate,
    required this.drawDate,
    required this.prize,
    required this.logo,
    required this.couponNo,
    required this.product,
  });
}
