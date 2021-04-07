import 'package:flutter/foundation.dart';

///Class Transaction
///The transaction class represents a note that has the following arguments:
/// ```dart
/// - @required String id: unique Transaction identifier
///
///
/// - @required String title: Transaction title
///
/// - @required double value: Transaction value
/// ```
///   (negative for expenses and positive for revenues)
///
///```dart
///
/// - @required String date: date the Transaction was made
///
/// - String description: Transaction description
///     - default: " "
///
/// - bool completed: true if the transaction has been received / paid, and false otherwise
///    - default: false
///
/// - bool monthly: true if it is a bill with a monthly charge,
/// it will generate several bills with the same day in all months ahead.
/// The value of each note can be modified individually.
///    - default: false
///
/// - int intallments: the parcel number of the note (1 if it is a single note)
///    - default: 1
///
/// - int totalInstallments: the total number of installments (1 if it is a single note)
///     - default: 1
/// ```
class Transaction {
  final String id;
  final String title;
  final double value;
  final String date;
  String description;
  bool completed;
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
    this.completed = false,
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
        completed = json['completed'],
        installments = json['installments'],
        totalInstallments = json['totalInstallments'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'value': value,
        'date': date,
        'description': description,
        'monthly': monthly,
        'completed': completed,
        'installments': installments,
        'totalInstallments': totalInstallments,
      };
}
