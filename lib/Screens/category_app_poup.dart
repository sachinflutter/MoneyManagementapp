import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_management_app/db/category/categoryy.dart';
import 'package:money_management_app/models/category/categoey.dart';
ValueNotifier<CategoryType>selectedCategoryNotifier =ValueNotifier(CategoryType.income);
Future<void>showCategoryAddPoup(BuildContext context)async{
   final _nameeditingcontroller=TextEditingController();
  showDialog(context: context, builder: (ctx) {
    return SimpleDialog(
     title: const Text("ADD Category"),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _nameeditingcontroller,
            decoration: InputDecoration(
              hintText: "Category Name",
              border: OutlineInputBorder()
            ),
          ),
        ),
        Padding(padding: EdgeInsets.all(8),
        child: Row(
          children: [
            RadioButton(title: "income", type: CategoryType.income),
            RadioButton(title: "Expense", type: CategoryType.expense),
          ],
        ),),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(onPressed: () {
            final _name=_nameeditingcontroller.text;
            if(_name.isEmpty)
              {
                return;
              }
            final _type=selectedCategoryNotifier.value;
            final _category=CategoryModel(id: DateTime.now().microsecondsSinceEpoch.toString(), name: _name, type:_type);
            CategoryDb().insertCategory(_category);
            Navigator.of(ctx).pop();
          }, child: Text("ADD")),
        )
      ],
    );
  },);
}
class RadioButton extends StatefulWidget {
  final String title;
  final CategoryType type;

  const RadioButton({Key? key, required this.title, required this.type}) : super(key: key);

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(valueListenable: selectedCategoryNotifier, builder: (context, value, child) {
          return Radio<CategoryType>(value: widget.type, groupValue: selectedCategoryNotifier.value, onChanged: (value) {
            selectedCategoryNotifier.value=value!;
            selectedCategoryNotifier.notifyListeners();
          },);
        },),
        Text(widget.title),
      ],
    );
  }
}
