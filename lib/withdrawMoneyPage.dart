import 'package:flutter/material.dart';
import 'debt.dart';
import 'main.dart';

class WithdrawMoneyPage extends StatelessWidget {
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Withdraw money'),
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
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: amountController,
              decoration: InputDecoration(hintText: "Amount to Withdraw"),
              keyboardType: TextInputType.number,
            ),

            ElevatedButton(
              child: Text('Withdraw money'),
              onPressed: () {
                final amount = double.tryParse(amountController.text) ?? 0;
                globalNetBalance -= amount;
                // İşlem geçmişine ekle
                transactionHistory.add(Transaction(type: 'withdraw', amount: amount, dateTime: DateTime.now()));
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('₺$amount withdrawn from balance')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}