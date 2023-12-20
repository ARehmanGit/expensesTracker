import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

enum Category { business, leisure, food, travel }

final categoryIcons = {
  Category.business: Icons.business_center_rounded,
  Category.food: Icons.food_bank_rounded,
  Category.leisure: Icons.movie_sharp,
  Category.travel: Icons.airplanemode_on_sharp
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category});

  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate => DateFormat('yyyy-MM-dd').format(date);
}

List<Expense> myExpensesList = [
  Expense(
      title: 'Movie Tickets',
      amount: 10.99,
      date: DateTime.now(),
      category: Category.leisure),
  Expense(
      title: 'AirPlane Fare',
      amount: 76.99,
      date: DateTime.now(),
      category: Category.travel),
  Expense(
      title: 'Fine Dining ',
      amount: 99,
      date: DateTime.now(),
      category: Category.food),
];
