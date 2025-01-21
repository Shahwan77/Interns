import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:int_tst/expense_section/expense_details.dart';
import 'package:intl/intl.dart';
import 'model/model.dart';

class ExpenseTracker extends StatefulWidget {
  @override
  _ExpenseTrackerState createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  final _box = GetStorage();
  final _reasonController = TextEditingController();
  final _amountController = TextEditingController();

  List<Expense> getExpenses() {
    final expensesData = _box.read<List>('expenses') ?? [];
    return expensesData
        .map((e) => Expense.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  void saveExpense() {
    final reason = _reasonController.text;
    final amount = double.tryParse(_amountController.text) ?? 0;

    if (reason.isEmpty || amount <= 0) return;

    final expense =
        Expense(reason: reason, amount: amount, dateTime: DateTime.now());
    final expenses = getExpenses();
    expenses.add(expense);

    _box.write('expenses', expenses.map((e) => e.toJson()).toList());

    _reasonController.clear();
    _amountController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final expenses = getExpenses();

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExpenseDetailPage(),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.arrow_forward_ios_sharp),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _reasonController,
              decoration: InputDecoration(labelText: 'Reason'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
          ),
          ElevatedButton(onPressed: saveExpense, child: Text('Save Expense')),
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return ListTile(
                  title: Text(expense.reason),
                  subtitle: Text('₹${expense.amount.toStringAsFixed(2)}'),
                  trailing: Text(
                      DateFormat('dd-MM-yyyy HH:mm').format(expense.dateTime)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
