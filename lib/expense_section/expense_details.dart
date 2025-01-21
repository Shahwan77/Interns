import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import 'model/model.dart';

class ExpenseDetailPage extends StatefulWidget {
  @override
  _ExpenseDetailPageState createState() => _ExpenseDetailPageState();
}

class _ExpenseDetailPageState extends State<ExpenseDetailPage> {
  final _box = GetStorage();
  DateTime? _fromDate;
  DateTime? _toDate;
  List<Expense> _filteredExpenses = [];

  List<Expense> getExpenses() {
    final expensesData = _box.read<List>('expenses') ?? [];
    return expensesData
        .map((e) => Expense.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  void filterExpenses() {
    final allExpenses = getExpenses();
    setState(() {
      _filteredExpenses = allExpenses.where((expense) {
        if (_fromDate != null && expense.dateTime.isBefore(_fromDate!))
          return false;
        if (_toDate != null && expense.dateTime.isAfter(_toDate!)) return false;
        return true;
      }).toList();
    });
  }

  double calculateTotal() {
    return _filteredExpenses.fold(0.0, (sum, item) => sum + item.amount);
  }

  Future<void> selectDate(BuildContext context, bool isFrom) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        if (isFrom) {
          _fromDate = pickedDate;
        } else {
          _toDate = pickedDate;
        }
      });
      filterExpenses();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expense Details')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => selectDate(context, true),
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        _fromDate == null
                            ? 'From Date'
                            : DateFormat('dd-MM-yyyy').format(_fromDate!),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => selectDate(context, false),
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        _toDate == null
                            ? 'To Date'
                            : DateFormat('dd-MM-yyyy').format(_toDate!),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredExpenses.length,
              itemBuilder: (context, index) {
                final expense = _filteredExpenses[index];
                return ListTile(
                  title: Text(expense.reason),
                  subtitle: Text('₹${expense.amount.toStringAsFixed(2)}'),
                  trailing:
                      Text(DateFormat('dd-MM-yyyy').format(expense.dateTime)),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total: ₹${calculateTotal().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
