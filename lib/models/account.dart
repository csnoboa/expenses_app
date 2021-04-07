import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Account {
  final String title;
  double _balance = 0;
  List<Transaction> _transactions;
  String description;

  Account({
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

  double getBalance() {
    _balance = 0;
    for (var i in _transactions) {
      _balance += i.value;
    }
    return _balance;
  }

  Account.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        _balance = json['_balance'],
        _transactions = json['_transactions'],
        description = json['description'];

  Map<String, dynamic> toJson() => {
        'title': title,
        '_balance': _balance,
        'description': description,
        '_transactions': _transactions,
      };
}
