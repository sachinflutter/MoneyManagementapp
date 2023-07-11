import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:money_management_app/models/category/categoey.dart';
const CATEGORY_DB_NAME='category_database';
abstract class CategoryDbfuctions{
  Future<List<CategoryModel>>getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleateCategory(String categoryID);
 }
class CategoryDb implements CategoryDbfuctions {

  CategoryDb._internal();
  static CategoryDb instance= CategoryDb._internal();
  factory CategoryDb()
  {
    return instance;
  }
  ValueNotifier<List<CategoryModel>> incomeCategoryListListener = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListListener = ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDb.put(value.id,value);
    refreshUi();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDb.values.toList();
  }

  Future<void> refreshUi() async
  {
    final _allCatefories = await getCategories();
    incomeCategoryListListener.value.clear();
    expenseCategoryListListener.value.clear();
    await Future.forEach(_allCatefories, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomeCategoryListListener.value.add(category);
      } else {
        expenseCategoryListListener.value.add(category);
      }
    });
    incomeCategoryListListener.notifyListeners();
    expenseCategoryListListener.notifyListeners();
  }

  @override
  Future<void> deleateCategory(String categoryID)
  async {
    final _categoryDb =await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDb.delete(categoryID);
    refreshUi();
  }
}
