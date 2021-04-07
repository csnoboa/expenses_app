import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Class CategoryModel
/// The CategoryModel class represents a Category, that can be: Food, Travel, Study...
///
/// Has the following arguments:
/// ```dart
/// @required String title: CategoryModel title
/// String description: CategoryModel description
///
///
/// ```
/// And the following methods:
/// ```dart
/// void addTransaction(Transaction tr): add a Transaction to the category
/// void removeTransaction(Transaction tr): remove the Transaction tr from the CategoryModel
/// int sizeTransactions(): returns the number of registered transactions
///
/// List<Transaction> getTransactions(): returns all the transactions
///
/// double getBalance(DateTime start, DateTime end): returns the expected balance in Date range
///
///
/// ```
class CategoryModel {
  final String title;
  double _balance = 0;
  List<Transaction> _transactions;
  String description;
  final Color color;

  CategoryModel({@required this.title, this.description = " ", this.color});

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

  double getBalance(DateTime start, DateTime end) {
    _balance = 0;

    for (var i in _transactions) {
      // if i.date > start and i.date < end
      _balance += i.value;
    }

    return _balance;
  }

  CategoryModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        _transactions = json['_transactions'],
        description = json['description'],
        color = json['color'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        '_transactions': _transactions,
        'color': color
      };
}
