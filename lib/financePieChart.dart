import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'main.dart'; // Assuming transactionHistory and globalDebtList are defined here

class FinancePieChart extends StatelessWidget {
  final sectionColors = [
    Colors.teal,
    Colors.deepPurple,
    Colors.orange,
    Colors.yellow,
  ];
  double calculateTotalWithdrawn() {
    double totalWithdrawn = 0;
    for (var transaction in transactionHistory) {
      if (transaction.type == 'withdraw') {
        totalWithdrawn += transaction.amount;
      }
    }
    return totalWithdrawn;
  }
  @override
  Widget build(BuildContext context) {
    double depositMoney = 0;
    double borrowedMoney = 0;
    double moneyLoaned = 0;
    double moneyWithdrawn = calculateTotalWithdrawn();

    // Process transaction history
    for (var transaction in transactionHistory) {
      switch (transaction.type) {
        case 'add':
          depositMoney += transaction.amount;
          break;
        case 'withdraw':
          moneyWithdrawn += transaction.amount;
          break;
      // Add cases for other transaction types if necessary
      }
    }

    // Process debt history
    for (var debt in globalDebtList) {
      if (debt.isLent) {
        moneyLoaned += debt.amount;
      } else {
        borrowedMoney += debt.amount;
      }
    }

    final data = {
      'Deposit Money': depositMoney,
      'Borrowed Money': borrowedMoney,
      'Money Loaned': moneyLoaned,
      'Money Withdrawn': moneyWithdrawn,
    };

    // Total value calculation
    final total = data.values.reduce((sum, element) => sum + element);

    // Create sections for the pie chart
    List<PieChartSectionData> sections = data.entries
        .toList()
        .asMap()
        .entries
        .map((entry) {
      double percentage = (entry.value.value / total) * 100;
      return PieChartSectionData(
        color: sectionColors[entry.key % sectionColors.length],
        value: percentage,
        radius: 100,
        showTitle: false, // We will show titles below the chart instead
      );
    })
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance Overview'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                sections: sections,
                sectionsSpace: 3,
                centerSpaceRadius: 60,
                centerSpaceColor: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              children: data.entries
                  .toList()
                  .asMap()
                  .entries
                  .map((entry) {
                double percentage = (entry.value.value / total) * 100;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.stop, color: sectionColors[entry.key % sectionColors.length], size: 28),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${entry.value.key} (${percentage.toStringAsFixed(2)}%)',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Text(
                        '${entry.value.value.toStringAsFixed(0)} TL',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                );
              })
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}