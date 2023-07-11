import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/categoryy.dart';
import 'package:money_management_app/db/transactions/transactions.dart';
import 'package:money_management_app/models/category/categoey.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDb.instance.refreshUi();
    return ValueListenableBuilder(valueListenable: TransactionDB.instance.transactionNotifierListner, builder: (context, newlist, child) {
      return ListView.separated(itemBuilder: (context, index) {
        final _value=newlist[index];
        return Slidable(
          key: Key(_value.id!),
          startActionPane: ActionPane(motion: ScrollMotion(), children: [
            SlidableAction(onPressed: (context) {
              TransactionDB.instance.deleateTransaction(_value.id!);
            },icon: Icons.delete,label: "deleate",)
          ]),
          child: Card(
            elevation: 10,
            margin: EdgeInsets.all(10),
            child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: _value.type==CategoryType.income?Colors.green:Colors.red,
                  child: Center(child: Text(parseDate(_value.date),style: TextStyle(color: Colors.white))),
                ),
                title: Text("Rs${_value.amount}"),
                subtitle: Text(_value.category.name),
                trailing: IconButton(icon:Icon(Icons.delete), onPressed: () {  },)
            ),
          ),
        );

      }, separatorBuilder:(context, index) => Divider(
        color: Colors.grey,
        height: 10,
      ), itemCount: newlist.length);
    });

  }
  String parseDate(DateTime date)
  {
    final _date= DateFormat.MMMd().format(date);
    final _splitedDate=_date.split(" ");
    return ("${_splitedDate.last}\n${_splitedDate.first}");
    //return "${date.day}\n${date.month}";
  }
}
