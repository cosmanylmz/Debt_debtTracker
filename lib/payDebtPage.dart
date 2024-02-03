import 'package:flutter/material.dart';
import 'debt.dart';
import 'main.dart';

class PayDebtPage extends StatelessWidget {
  final Debt debt;

  PayDebtPage({Key? key, required this.debt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pay Debt')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text('Pay Debt: ${debt.debtorName} - ${debt.amount} TL'),
            ElevatedButton(
              child: const Text('Pay'),
              onPressed: () {
                if (globalNetBalance >= debt.amount) {
                  globalNetBalance -= debt.amount; // Bakiyeden borç miktarını çıkar
                  globalDebtList.remove(debt); // Borç kaydını sil
                  // İşlem geçmişine ekle
                  transactionHistory.add(Transaction(type: 'pay', amount: debt.amount, dateTime: DateTime.now()));
                  Navigator.pop(context); // Ödeme sonrası önceki ekrana dön
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Debt paid: ${debt.debtorName} - ${debt.amount} TL')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Insufficient balance')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
