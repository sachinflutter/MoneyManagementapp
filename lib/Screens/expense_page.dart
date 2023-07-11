import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/categoryy.dart';
class expense extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable:CategoryDb().expenseCategoryListListener , builder: (context, newlist1, child) {
      return ListView.separated(itemBuilder: (context, index) {
        final category=newlist1[index];
        return Card(
          elevation: 10,
          margin: EdgeInsets.all(10),
          child: ListTile(
              title: Text(category.name),
              trailing: IconButton(icon:Icon(Icons.delete), onPressed: () {
                CategoryDb.instance.deleateCategory(category.id);
              },)
          ),
        );

      }, separatorBuilder:(context, index) => Divider(
        color: Colors.grey,
        height: 10,
      ), itemCount: newlist1.length);
    },);
  }
}
