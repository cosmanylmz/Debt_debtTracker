import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // intl paketini içe aktar
import 'debt.dart';
import 'main.dart';
import 'notificationManager.dart';

class GiveDebtPage extends StatelessWidget {
  final TextEditingController creditorNameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<Debt> debtList; // Define the named parameter
  final NotificationManager notificationManager = NotificationManager();

  GiveDebtPage({Key? key, required this.debtList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Give Debt'),
        automaticallyImplyLeading: true,
        actions: [
          Image.asset(
            'assets/images/logo2.png',
            width: 40,
            height: 40,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: creditorNameController,
                decoration: const InputDecoration(hintText: "To Whom"),
              ),
              TextFormField(
                controller: amountController,
                decoration: const InputDecoration(hintText: "How Much"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: dueDateController,
                decoration: const InputDecoration(hintText: "Due Date (dd/MM/yyyy)"),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a date';
                  }
                  try {
                    final DateFormat format = DateFormat('dd/MM/yyyy');
                    format.parseStrict(value);
                  } on FormatException {
                    return 'Invalid date format. It should be in dd/MM/yyyy format';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    'Lend Money',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final amount = double.tryParse(amountController.text) ?? 0;
                    final newDebt = Debt(
                      debtorName: creditorNameController.text,
                      amount: amount,
                      dueDate: DateFormat('dd/MM/yyyy').parseStrict(dueDateController.text),
                      creationTime: DateTime.now(),
                      isLent: true,
                    );
                    globalDebtList.add(newDebt);
                    transactionHistory.add(Transaction(type: 'pay', amount: amount, dateTime: DateTime.now()));

                    // Update notifications
                    notificationManager.scheduleNotifications();

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Debt added: ${newDebt.debtorName} - ${newDebt.amount} TL')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
