import'package:flutter/material.dart';
import 'package:hive/hive.dart';
import "package:hive_flutter/adapters.dart";
import 'package:money_management_app/Screens/category_app_poup.dart';
import 'package:money_management_app/db/category/categoryy.dart';
import '../models/category/categoey.dart';
import '../models/transaction/transaction.dart';
import 'MainPage.dart';
import 'add_Transaction.dart';
import 'incom_expensePage.dart';
Future<void> main() async {
  final obj1=CategoryDb();
  final obj2=CategoryDb();
  print("ch");
  print(obj1==obj2);
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(CategoryModelAdapter().typeId))
    {
      Hive.registerAdapter(CategoryModelAdapter());
    }
  if(!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId))
  {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if(!Hive.isAdapterRegistered(TransactionmodelAdapter().typeId))
  {
    Hive.registerAdapter(TransactionmodelAdapter());
  }
  runApp(
    MaterialApp(
      home: HomePage(),
      routes: {
        ScreenaddTransaction.routeName:(ctx)=>const ScreenaddTransaction()
      },
    ), // Wrap your app
  );
}
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
var index=0;
static ValueNotifier <int> selectedindexNotifier=ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("Money Manager"),
        centerTitle: true,
    ),
      body:SafeArea(
        child: ValueListenableBuilder(valueListenable:selectedindexNotifier , builder: (BuildContext context, value, Widget? child) {
          return screens[value];
        },),
      ),
      //Center(child: screens[index],),
      floatingActionButton: FloatingActionButton(onPressed: () {
        if(selectedindexNotifier.value==0)
          {
            Navigator.of(context).pushNamed(ScreenaddTransaction.routeName);
            print("Add transaction");
          }else
            {
              print("Add category");
              showCategoryAddPoup(context);
              // final _sample =CategoryModel(id: DateTime.now().microsecondsSinceEpoch.toString(), name: "travel", type: CategoryType.expense);
              // CategoryDb().insertCategory(_sample);
            }
      },
      child: Icon(Icons.add),),
      bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.shifting,
        elevation: 5,
        currentIndex: selectedindexNotifier.value,
        selectedItemColor: Colors.blue,
         onTap: (value) {
           setState(() {
             selectedindexNotifier.value=value;
           });
         },
        items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Transactions"
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categories"
        ),
      ],),
    );
  }
  var screens=[
    Homepage(),
    income_expensepage(),
  ];
}
