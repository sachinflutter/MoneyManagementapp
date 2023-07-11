import 'package:hive/hive.dart';
part 'categoey.g.dart';
@HiveType(typeId: 2)
enum CategoryType{
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}
@HiveType(typeId: 1)
class CategoryModel{
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool isdeleated;
  @HiveField(3)
  final CategoryType type;
  CategoryModel( {required this.id,required this.name,this.isdeleated=false,required this.type});

}


