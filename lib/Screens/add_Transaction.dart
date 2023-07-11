import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/categoryy.dart';
import 'package:money_management_app/db/transactions/transactions.dart';
import 'package:money_management_app/models/category/categoey.dart';
import 'package:money_management_app/models/transaction/transaction.dart';

class ScreenaddTransaction extends StatefulWidget {
  static const routeName = "add-transaction";

  const ScreenaddTransaction({Key? key}) : super(key: key);

  @override
  State<ScreenaddTransaction> createState() => _ScreenaddTransactionState();
}

class _ScreenaddTransactionState extends State<ScreenaddTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategorytype;
  CategoryModel? _selectedCategorymodel;
  String? _categoryId;
  final _purposeTexteditingcontroller=TextEditingController();
  final _amountTexteditingcontroller=TextEditingController();
  @override
  void initState() {
    _selectedCategorytype = CategoryType.income;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _purposeTexteditingcontroller,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: "Purpose",
              ),
            ),
            TextFormField(
              controller: _amountTexteditingcontroller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Amount",
              ),
            ),
            TextButton.icon(
              onPressed: () async {
                final _selecteddatetemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate:
                        DateTime.now().subtract(const Duration(days: 30)),
                    lastDate: DateTime.now());
                if (_selecteddatetemp == null) {
                  return;
                } else {
                  print(_selecteddatetemp.toString());
                  setState(() {
                    _selectedDate = _selecteddatetemp;
                  });
                }
              },
              icon: Icon(Icons.calendar_today),
              label: Text(_selectedDate == null
                  ? "Select Date"
                  : _selectedDate!.toString()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                      value: CategoryType.income,
                      //radiobutton value
                      groupValue: _selectedCategorytype,
                      //user select cheynne value
                      onChanged: (newvalue) {
                        setState(() {
                          _selectedCategorytype = CategoryType.income;
                          _categoryId=null;
                        });
                      },
                    ),
                    Text("Income"),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: CategoryType.expense,
                      groupValue: _selectedCategorytype,
                      onChanged: (value) {
                        setState(() {
                          _selectedCategorytype = CategoryType.expense;
                          _categoryId=null;
                        });
                      },
                    ),
                    Text("Expense"),
                  ],
                ),
              ],
            ),
            DropdownButton(
              hint: Text("Select Category"),
              value: _categoryId,
              items: (_selectedCategorytype == CategoryType.income
                      ? CategoryDb().incomeCategoryListListener
                      : CategoryDb().expenseCategoryListListener)
                  .value
                  .map((e) {
                return DropdownMenuItem(
                  child: Text(e.name),
                  value: e.id,
                  onTap:() {
                    _selectedCategorymodel=e;
                  },
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _categoryId = value;
                });
              },
            ),
            ElevatedButton(onPressed: () {
              addTransaction();
            }, child: Text("submit"))
          ],
        ),
      )),
    );
  }
  Future<void>addTransaction()async{
    final _purposeText=_purposeTexteditingcontroller.text;
    final _amountText=_amountTexteditingcontroller.text;
    if(_purposeText.isEmpty)
      {
        return;
      }
    if(_amountText.isEmpty)
      {
        return;
      }
    if(_categoryId==null)
      {
        return;
      }
    if(_selectedDate==null)
      {
        return;
      }
    final _parsedAmount=double.tryParse(_amountText);
    if(_parsedAmount==null)
      {
        return;
      }
    if(_selectedCategorymodel==null)
      {
        return;
      }
    final _model= Transactionmodel(purpose: _purposeText, category: _selectedCategorymodel!, type: _selectedCategorytype!, amount: _parsedAmount, date: _selectedDate!);
    await TransactionDB.instance.addTransaction(_model);
    Navigator.of(context).pop();
    TransactionDB.instance.refresh();
  }
}
