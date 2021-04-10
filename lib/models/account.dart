import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Class Account
/// The Account class represents a Bank Account that has the following arguments:
/// ```dart
/// @required String title: Account title
/// String description: Account description
///
///
/// ```
/// And the following methods:
/// ```dart
/// void addTransaction(Transaction tr): add a Transaction to the account
/// void removeTransaction(Transaction tr): remove the Transaction tr from the Account
/// int sizeTransactions(): returns the number of registered transactions
///
/// List<Transaction> getTransactions(): returns all the transactions
///
/// void addMensalTransaction(Transaction tr): add a Mensal Transaction to the account
/// void removeMensalTransaction(Transaction tr): remove the Mensal Transaction tr from the Mensal Transactions list
/// int sizeMensalTransactions(): returns the number of registered mensal transactions
///
/// List<Transaction> getMensalTransactions(): returns all the mensal transactions
///
///
/// double getExpectedBalance(DateTime date): returns the expected balance in the account by the date "date"
///
/// double getActualBalance(DateTime date): returns the actual balance in the account by the date "date"
///   - calculates only completed transactions (completed = true)
///
/// ```
class Account {
  final String title;
  double _expectedBalance = 0;
  double _actualBalance = 0;
  List<Transaction> _transactions;
  List<Transaction> _mensalTransactions;
  String description;

  Account({
    @required this.title,
    this.description = " ",
  });

  void addTransaction(Transaction tr) {
    _transactions.add(tr);
  }

  void addMensalTransaction(Transaction tr) {
    //para essa data em diante
    _mensalTransactions.add(tr);
    _transactions.add(tr);
  }

  int sizeTransactions() {
    return _transactions.length;
  }

  int sizeMensalTransactions() {
    return _mensalTransactions.length;
  }

  void removeTransaction(Transaction tr) {
    _transactions.remove(tr);
  }

  void removeMensalTransaction(Transaction tr) {
    //para essa data em diante
    _mensalTransactions.remove(tr);
    _transactions.remove(tr);
  }

  List<Transaction> getTransactions() {
    return _transactions;
  }

  List<Transaction> getMensalTransactions() {
    return _transactions;
  }

  double getExpectedBalance(DateTime date) {
    //To do: filter the _transactions by the date (all the _transactions before the date)

    _expectedBalance = 0;
    for (var i in _transactions) {
      // if i.date < date
      _expectedBalance += i.value;
    }
    return _expectedBalance;
  }

  double getActualBalance(DateTime date) {
    //To do: filter the _transactions by the date (all the _transactions before the date)

    _actualBalance = 0;
    for (var i in _transactions) {
      // if i.date < date
      if (i.completed) {
        _actualBalance += i.value;
      }
    }
    return _actualBalance;
  }

  Account.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        _transactions = json['_transactions'],
        description = json['description'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        '_transactions': _transactions,
      };
}
