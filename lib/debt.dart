class Transaction {
  final String type; // 'add' ya da 'withdraw'
  final double amount;
  final DateTime dateTime;

  Transaction({required this.type, required this.amount, required this.dateTime});
}

class Debt {
  String debtorName;
  double amount;
  DateTime dueDate;
  DateTime creationTime;
  bool isLent;

  Debt({required this.debtorName, required this.amount, required this.dueDate, DateTime? creationTime, this.isLent = false})
      : creationTime = creationTime ?? DateTime.now();
}