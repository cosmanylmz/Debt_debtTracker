import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'debt.dart';
import 'main.dart';

class AddDebtPage extends StatelessWidget {
  final TextEditingController debtorNameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Borç Al'),
        automaticallyImplyLeading: true, // Geri dönüş butonunu kaldır
        actions: [

          // Logo eklemek için leading yerine bu Image widget'ini ekleyin
          Image.asset(
            'assets/images/logo2.png', // Logo dosyanızın yolu
            width: 40, // Logo genişliği
            height: 40, // Logo yüksekliği
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: debtorNameController,
                decoration: const InputDecoration(
                  labelText: "From whom",
                ),
              ),
              TextFormField(
                controller: amountController,
                decoration: const InputDecoration(
                  labelText: "How much",
                ),
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
                decoration: const InputDecoration(
                  labelText: "Payment Deadline (gg/aa/yyyy)",
                ),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a date';
                  }
                  try {
                    final DateFormat format = DateFormat('dd/MM/yyyy');
                    format.parseStrict(value);
                  } on FormatException {
                    return 'Invalid date format. must be in dd/mm/yyyy format';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                child: const Text('Get Loan'),
                onPressed: () {
                  final amount = double.tryParse(amountController.text) ?? 0;
                  final newDebt = Debt(
                    debtorName: debtorNameController.text,
                    amount: amount,
                    dueDate: DateFormat('dd/MM/yyyy').parseStrict(dueDateController.text),
                    creationTime: DateTime.now(),
                    isLent: false,
                  );
                  globalDebtList.add(newDebt);
                  globalNetBalance += amount;
                  transactionHistory.add(Transaction(type: 'Borç alındı', amount: amount, dateTime: DateTime.now()));

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Debt added: ${newDebt.debtorName} - ${newDebt.amount} TL')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}