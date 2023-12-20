import 'package:expensetracker/expensecard.dart';
import 'package:expensetracker/expenses.dart';
import 'package:expensetracker/newexpense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ExpensesHome extends StatefulWidget {
  const ExpensesHome({super.key});

  @override
  State<ExpensesHome> createState() => _ExpensesHomeState();
}

class _ExpensesHomeState extends State<ExpensesHome> {
  void openBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => NewExpense(onExpense: saveExpense),
    );
  }

  void removeExpense(Expense expense) {
    final expenseIndex = myExpensesList.indexOf(expense);
    setState(
      () {
        myExpensesList.remove(expense);
      },
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              myExpensesList.insert(expenseIndex, expense);
            });
          },
        ),
        content: const Text("Expense Succesfully Removed!")));
  }

  void saveExpense(Expense expense) {
    setState(() {
      myExpensesList.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/apppencil.png',
              fit: BoxFit.cover,
              width: 300,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Add New Expenses",
            style: TextStyle(
                fontWeight: FontWeight.w300, fontSize: 28, letterSpacing: 1),
          ),
        ].animate().slide().fadeIn(
              duration: const Duration(milliseconds: 400),
            ));
    if (myExpensesList.isNotEmpty) {
      mainContent = Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Animate(
          effects: const [
            SlideEffect(
              begin: Offset(-1, 0),
              duration: Duration(milliseconds: 300),
            ),
            FadeEffect(duration: Duration(milliseconds: 400))
          ],
          child: ListView.builder(
            itemCount: myExpensesList.length,
            itemBuilder: (context, index) {
              final indexexpense = myExpensesList[index];
              return Dismissible(
                  onDismissed: (direction) {
                    removeExpense(indexexpense);
                  },
                  key: ValueKey(indexexpense),
                  child: ExpenseCard(expense: indexexpense));
            },
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Theme.of(context).colorScheme.inverseSurface,
        title: const Text('My ExpenseTracker'),
        actions: [
          IconButton(
              onPressed: openBottomSheet,
              icon: const Icon(
                Icons.add_circle_rounded,
                size: 40,
              )),
          const SizedBox(
            width: 8,
          )
        ],
      ),
      body: mainContent,
    );
  }
}
