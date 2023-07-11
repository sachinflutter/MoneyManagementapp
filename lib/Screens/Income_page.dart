import 'package:flutter/material.dart';

import '../db/category/categoryy.dart';
class income extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
     return ValueListenableBuilder(valueListenable:CategoryDb().incomeCategoryListListener , builder: (context, newlist, child) {
      return ListView.separated(itemBuilder: (context, index) {
        final category=newlist[index];
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
      ), itemCount: newlist.length);
    },);
  }
}
