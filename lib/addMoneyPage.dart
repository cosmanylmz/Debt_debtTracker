import 'package:flutter/material.dart';
import 'debt.dart';
import 'main.dart';

class AddMoneyPage extends StatelessWidget {
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Money'),
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
        child: Column(
          children: <Widget>[
            TextField(
              controller: amountController,
              decoration: const InputDecoration(hintText: "Amount to be added"),
              keyboardType: TextInputType.number,
            ),

            ElevatedButton(
              child: const Text('Add'),
              onPressed: () {
                final amount = double.tryParse(amountController.text) ?? 0;
                globalNetBalance += amount;
                transactionHistory.add(Transaction(type: 'add', amount: amount, dateTime: DateTime.now()));
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('₺$amount added to the balance')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}