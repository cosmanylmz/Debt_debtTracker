import 'package:flutter/material.dart';
import 'myBottomNavigationBar.dart';
import 'debt.dart';


List<Transaction> transactionHistory = [];
List<Debt> globalDebtList = [];
double globalNetBalance = 0;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hoşgeldiniz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyBottomNavigationBar(), // MyBottomNavigationBar widget'ını ana ekrana ayarlayın
    );
  }
}
