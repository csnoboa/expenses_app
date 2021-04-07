import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String title;
  final double value;
  final String date;
  String description;
  bool monthly;
  int installments;
  int totalInstallments;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.value,
    @required this.date,
    this.description = " ",
    this.monthly = false,
    this.installments = 1,
    this.totalInstallments = 1,
  });

  Transaction.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        value = json['value'],
        date = json['date'],
        description = json['description'],
        monthly = json['monthly'],
        installments = json['installments'],
        totalInstallments = json['totalInstallments'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'value': value,
        'date': date,
        'description': description,
        'monthly': monthly,
        'installments': installments,
        'totalInstallments': totalInstallments,
      };
}
