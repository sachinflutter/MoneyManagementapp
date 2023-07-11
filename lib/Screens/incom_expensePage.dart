import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/categoryy.dart';
import 'Income_page.dart';
import 'expense_page.dart';
class income_expensepage extends StatefulWidget {
  const income_expensepage({Key? key}) : super(key: key);

  @override
  State<income_expensepage> createState() => _income_expensepageState();
}

class _income_expensepageState extends State<income_expensepage> {
  @override
void initState() {
   CategoryDb().refreshUi();
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            labelPadding: EdgeInsets.zero,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
            Tab(
              text: "Income",
            ),
            Tab(
              text:"expense",
            ),
          ],
          ),
        ),
        body: TabBarView(
          children: [
            income(),
            expense(),
          ],
        ),
      ),
    );
  }
}
