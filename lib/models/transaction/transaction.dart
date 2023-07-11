import 'package:hive/hive.dart';
import 'package:money_management_app/models/category/categoey.dart';
part 'transaction.g.dart';
@HiveType(typeId: 3)
class Transactionmodel{
  @HiveField(0)
  final String purpose;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final CategoryType type;
  @HiveField(4)
  final CategoryModel category;
  @HiveField(5)
  String? id;

  Transactionmodel({required this.purpose,required this.category,required this.type,required this.amount,required this.date,}){
    id=DateTime.now().microsecondsSinceEpoch.toString();
  }

}