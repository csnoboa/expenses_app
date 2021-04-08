import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Class CreditCard
/// The CreditCard class represents a Credit Card that has the following arguments:
/// ```dart
/// @required String title: Credit Card title
/// String description: Credit Card description
///
///
/// ```
/// And the following methods:
/// ```dart
/// void addTransaction(Transaction tr): add a Transaction to the credit card
/// void removeTransaction(Transaction tr): remove the Transaction tr from the CreditCard
/// int sizeTransactions(): returns the number of registered transactions
///
/// List<Transaction> getTransactions(): returns all the transactions
///
/// double getActualBill(DateTime start, DateTime end) : returns the actual bill in the credit card by the date "date"
///
///
/// ```
class CreditCard {
  final String title;
  double _actualBill = 0;
  List<Transaction> _transactions;
  String description;
  String billClosingDate;
  String billPaymentDate;

  CreditCard({
    @required this.title,
    this.description = " ",
  });

  void addTransaction(Transaction tr) {
    _transactions.add(tr);
  }

  int sizeTransactions() {
    return _transactions.length;
  }

  void removeTransaction(Transaction tr) {
    _transactions.remove(tr);
  }

  List<Transaction> getTransactions() {
    return _transactions;
  }

  double getActualBill(DateTime start, DateTime end) {
    //To do: filter the _transactions by the date (all the _transactions before the date)

    _actualBill = 0;
    for (var i in _transactions) {
      // if i.date < end and i.date > start
      _actualBill += i.value;
    }
    return _actualBill;
  }

  // double getActualBalance(DateTime date) {
  //   //To do: filter the _transactions by the date (all the _transactions before the date)

  //   _actualBalance = 0;
  //   for (var i in _transactions) {
  //     // if i.date < date
  //     if (i.completed) {
  //       _actualBalance += i.value;
  //     }
  //   }
  //   return _actualBalance;
  // }

  CreditCard.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        _transactions = json['_transactions'],
        description = json['description'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        '_transactions': _transactions,
      };
}
