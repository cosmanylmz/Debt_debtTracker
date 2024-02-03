import 'package:flutter/material.dart';
import 'main.dart'; // Eğer Transaction sınıfını ve transactionHistory listesini burada tanımladıysanız

class TransactionHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
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
      body: ListView.builder(
        itemCount: transactionHistory.length,
        itemBuilder: (context, index) {
          final transaction = transactionHistory[index];
          String transactionTypeDescription;

          switch (transaction.type) {
            case 'add':
              transactionTypeDescription = 'Added Money';
              break;
            case 'withdraw':
              transactionTypeDescription = 'Withdrawn';
              break;
            case 'Borç alındı':
              transactionTypeDescription = 'Loan Received';
              break;
            case 'pay':
              transactionTypeDescription = 'Debt Paid';
              break;
            default:
              transactionTypeDescription = 'Transaction';
          }

          return ListTile(
            leading: Icon(Icons.history),
            title: Text('$transactionTypeDescription: ₺${transaction.amount}'),
            subtitle: Text('Date: ${transaction.dateTime.toLocal()}'),
          );
        },
      ),
    );
  }
}
