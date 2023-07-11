import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:money_management_app/models/transaction/transaction.dart';

const Transaction_DB_name="transaction-db";
abstract class TransactionDbFunctions{
  Future<void>addTransaction(Transactionmodel obj);
  Future<List<Transactionmodel>>getAllTransactions();
  Future<void>refresh();
  Future<void>deleateTransaction(String id);
}
class TransactionDB implements TransactionDbFunctions
{
  TransactionDB._internal();//named parameter creating
  static TransactionDB instance=TransactionDB._internal();//
  factory TransactionDB()
  {
    return instance;
}
ValueNotifier<List<Transactionmodel>> transactionNotifierListner= ValueNotifier([]);

  @override
  Future<void> addTransaction(Transactionmodel obj) async{
    final _db=await Hive.openBox<Transactionmodel>(Transaction_DB_name);
    _db.put(obj.id,obj);
  }
  Future<void>refresh()async{
    final _list=await getAllTransactions();
    _list.sort((first,second)=>second.date.compareTo(first.date));
    transactionNotifierListner.value.clear();
    transactionNotifierListner.value.addAll(_list);
    transactionNotifierListner.notifyListeners();
  }
  @override
  Future<List<Transactionmodel>> getAllTransactions()async {
    final _db=await Hive.openBox<Transactionmodel>(Transaction_DB_name);
    return _db.values.toList();
  }

  @override
  Future<void> deleateTransaction(String id) async{
    final _db=await Hive.openBox<Transactionmodel>(Transaction_DB_name);
    _db.delete(id);
    refresh();
  }


}