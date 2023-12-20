import 'package:expensetracker/expenses.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onExpense});

  final void Function(Expense expense) onExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  TextEditingController title = TextEditingController();
  TextEditingController amount = TextEditingController();
  DateTime? selectedDate;
  Category selectedCategory = Category.leisure;

  void addExpense() {
    final amountValue = double.tryParse(amount.text);
    final amountValid = amountValue == null || amountValue <= 0;

    if (title.text.trim().isEmpty || amountValid || selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
              title: const Text("Input is invalid"),
              content: const Text(
                  'Please make sure to enter valid Title,Amount,Date and Category'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text("OK"))
              ]);
        },
      );
      return;
    }
    widget.onExpense(
      Expense(
          title: title.text,
          amount: amountValue,
          date: selectedDate!,
          category: selectedCategory),
    );
    Navigator.pop(context);
  }

  String formatter(DateTime? time) {
    if (time != null) {
      return DateFormat('yyyy-MM-dd').format(time);
    } else {
      return 'Selected Date';
    }
  }

  Future<DateTime?> selectDatePicker() async {
    final DateTime now = DateTime.now();
    DateTime firstDate = DateTime(now.year - 1, now.month - 1, now.day - 1);
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      selectedDate = pickedDate;
    });
    return selectedDate;
  }

  @override
  void dispose() {
    title.dispose();
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const SizedBox(height: 40),
            TextField(
              controller: title,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  contentPadding: EdgeInsets.only(left: 4),
                  hintText: 'Title',
                  hintStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    controller: amount,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                        constraints: BoxConstraints.tightFor(width: 200),
                        border: UnderlineInputBorder(),
                        contentPadding: EdgeInsets.only(left: 4),
                        hintText: 'Amount \$',
                        hintStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  formatter(selectedDate),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                IconButton(
                    onPressed: () {
                      selectDatePicker();
                    },
                    icon: const Icon(
                      Icons.calendar_month_rounded,
                      size: 30,
                    ))
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const SizedBox(width: 4),
                DropdownButton(
                    padding: const EdgeInsets.only(left: 8.0),
                    value: selectedCategory,
                    items: Category.values
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.name.toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            )))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    }),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: ElevatedButton(
                      onPressed: addExpense,
                      child: const Text(
                        "Save",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
