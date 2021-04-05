import 'dart:convert';
import 'dart:io';

import 'package:expenses_app/models/transaction.dart';
import 'package:path_provider/path_provider.dart';

class TransactionStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/transaction_list.json');
  }

  Future<List<Transaction>> readTransaction() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      // tr recebe a lista de json decodificados
      List<Transaction> tr = (json.decode(contents) as List)
          .map((i) => Transaction.fromJson(i))
          .toList();

      return tr;
    } catch (e) {
      return null;
    }
  }

  Future<File> writeTransaction(List<Transaction> _transaction) async {
    final file = await _localFile;

    List<String> transactionString = [];

    //Converte cada item para o formato .json e coloca na nova lista transactionString
    for (var i in _transaction) {
      transactionString.add(jsonEncode(i.toJson()));
    }

    // Write the file the list of json
    return file.writeAsString('$transactionString');
  }
}
