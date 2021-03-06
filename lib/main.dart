import 'dart:io';
import 'package:expenses_app/components/chart.dart';
import 'package:expenses_app/components/transaction_form.dart';
import 'package:expenses_app/components/transaction_list.dart';
import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/storage/transaction_storage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              button: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  _addTransaction(String title, double value, String date) {
    final newTransaction = Transaction(
      id: _transactions.length.toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    TransactionStorage().writeTransaction(_transactions);

    Navigator.of(context).pop();
  }

  _removeTransaction(int index) {
    setState(() {
      _transactions.removeAt(index);
      TransactionStorage().writeTransaction(_transactions);
    });
  }

  final List<Transaction> _transactions = [];

  bool _showChart = true;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      String date = tr.date.replaceAll('/', '');
      date = date.substring(4, 8) + date.substring(2, 4) + date.substring(0, 2);
      DateTime dateTransaction = DateTime.parse(date);
      return dateTransaction
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool _isLandscape = mediaQuery.orientation == Orientation.landscape;

    TransactionStorage().readTransaction().then((value) {
      if (value != null && _transactions.isEmpty) {
        setState(() {
          for (var i in value) {
            _transactions.add(i);
          }
        });
      }
    });

    final appBar = AppBar(
      title: Text(
        'Expenses',
        style: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 20 * mediaQuery.textScaleFactor,
        ),
      ),
      actions: [
        if (_isLandscape && !Platform.isWindows)
          IconButton(
            icon: _showChart ? Icon(Icons.list) : Icon(Icons.pie_chart),
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
          ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
        ),
      ],
    );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showChart || !_isLandscape || Platform.isWindows)
              Container(
                height: _isLandscape
                    ? availableHeight * 0.75
                    : availableHeight * 0.3,
                child: Chart(_recentTransactions),
              ),
            if (!_showChart || !_isLandscape || Platform.isWindows)
              Container(
                height: _isLandscape ? availableHeight : availableHeight * 0.7,
                child: TransactionList(_transactions, _removeTransaction),
              ),
          ],
        ),
      ),
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _openTransactionFormModal(context),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
