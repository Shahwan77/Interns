class Expense {
  final String reason;
  final double amount;
  final DateTime dateTime;

  Expense({required this.reason, required this.amount, required this.dateTime});

  Map<String, dynamic> toJson() => {
    'reason': reason,
    'amount': amount,
    'dateTime': dateTime.toIso8601String(),
  };

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
    reason: json['reason'],
    amount: json['amount'],
    dateTime: DateTime.parse(json['dateTime']),
  );
}
