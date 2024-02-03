import 'package:flutter/material.dart';
import 'debt.dart';
import 'main.dart';  // Eğer globalNetBalance ve transactionHistory burada tanımlıysa

class DebtHistoryPage extends StatefulWidget {
  late final List<Debt> debts;
  @override
  DebtHistoryPage({Key? key, required this.debts}) : super(key: key);
  @override
  _DebtHistoryPageState createState() => _DebtHistoryPageState();
}

class _DebtHistoryPageState extends State<DebtHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debt Management'),
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
        itemCount: globalDebtList.length,
        itemBuilder: (BuildContext context, int index) {
          final debt = globalDebtList[index];
          final DateTime now = DateTime.now();
          final DateTime dueDate = debt.dueDate;
          final int daysUntilDue = dueDate.difference(now).inDays;

          // Vade tarihine kalan gün sayısını gösteren metni hesapla
          String dueText = daysUntilDue > 0 ? 'Days remaining: $daysUntilDue'
              : daysUntilDue == 0 ? 'due date' : 'payment overdue';

          return Dismissible(
            key: Key(debt.debtorName + index.toString()),
            background: Container(
              color: debt.isLent ? Colors.green : Colors.red,
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Icon(debt.isLent ? Icons.delete : Icons.payment, color: Colors.white),
              ),
            ),
            secondaryBackground: Container(
              color: Colors.green,
              alignment: Alignment.centerLeft,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.attach_money, color: Colors.white),
              ),
            ),
            confirmDismiss: (DismissDirection direction) async {
              if (direction == DismissDirection.endToStart) {
                return debt.isLent ?
                await _showReceivePaymentConfirmationDialog(context, debt, index) :
                await _showPaybackConfirmationDialog(context, debt, index);
              } else if (direction == DismissDirection.startToEnd) {
                return await _showDeleteConfirmationDialog(context, debt, index);
              }
              return false;
            },
            onDismissed: (direction) {
              if (direction == DismissDirection.startToEnd) {
                globalDebtList.removeAt(index);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${debt.debtorName} Deleted!')),
                );
              }
            },
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.person),
              ),
              title: Text(debt.debtorName),
              subtitle: Text('${debt.amount} TL - Payment Date: ${debt.dueDate.toLocal()} ($dueText) - Eklendi: ${debt.creationTime.toLocal()}'),
            ),
          );
        },
      ),
    );
  }

  Future<bool?> _showPaybackConfirmationDialog(BuildContext context, Debt debt,
      int index) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Debt Payment Approval'),
          content: Text(
              '${debt.amount} TL you will pay the debt. Do you approve?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('NO'),
            ),
            TextButton(
              onPressed: () {
                globalNetBalance -= debt.amount;
                transactionHistory.add(Transaction(type: 'Debt paid',
                    amount: debt.amount,
                    dateTime: DateTime.now()));
                globalDebtList.removeAt(index);
                Navigator.of(context).pop(true);
              },
              child: const Text('YES'),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showReceivePaymentConfirmationDialog(BuildContext context, Debt debt, int index) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Debt Repaid Confirmation'),
          content: Text('${debt.debtorName} paid back ${debt.amount}TL .Do you confirm that the debt has been repaid?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('NO'),
            ),
            TextButton(
              onPressed: () {
                globalNetBalance += debt.amount;
                transactionHistory.add(Transaction(type: 'Debt repaid', amount: debt.amount, dateTime: DateTime.now()));
                globalDebtList.removeAt(index);
                Navigator.of(context).pop(true);
              },
              child: const Text('YES'),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showDeleteConfirmationDialog(BuildContext context, Debt debt, int index) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Debt'),
          content: Text('${debt.debtorName} paid/received ${debt.amount}TL .Are you sure you want to delete this transaction?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('NO'),
            ),
            TextButton(
              onPressed: () {
                globalDebtList.removeAt(index);
                Navigator.of(context).pop(true);
              },
              child: const Text('YES'),
            ),
          ],
        );
      },
    );
  }

}
