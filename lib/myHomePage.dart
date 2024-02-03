import 'package:flutter/material.dart';
import 'addDebtPage.dart';
import 'debtHistoryPage.dart';
import 'transactionHistoryPage.dart';
import 'main.dart'; // Make sure you have the globalNetBalance and globalDebtList defined here.
import 'withdrawMoneyPage.dart';
import 'addMoneyPage.dart';
import 'giveDebtPage.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Debt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // You can add more pages and their navigation logic here
  List<Map<String, dynamic>> tiles = [
    {'color': Colors.blue, 'icon': Icons.monetization_on, 'label': 'Get loan', 'page': AddDebtPage()},
    {'color': Colors.red, 'icon': Icons.money_off, 'label': 'Lend Loan', 'page': GiveDebtPage(debtList: const [],)},
    {'color': Colors.green, 'icon': Icons.history, 'label': 'Debt management', 'page': DebtHistoryPage(debts: const [], key: null,)},
    {'color': Colors.purple, 'icon': Icons.transfer_within_a_station, 'label': 'Transaction History', 'page': TransactionHistoryPage()},
    {'color': Colors.orange, 'icon': Icons.add_circle, 'label': 'Add Money', 'page': AddMoneyPage()},
    {'color': Colors.cyan, 'icon': Icons.remove_circle, 'label': 'Withdraw Money', 'page': WithdrawMoneyPage()},
    // Add more tiles here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Row(
          children: [
            // Logo
            Padding(
              padding: const EdgeInsets.all(3.0), // İstenilen kenar boşluğunu ayarlayabilirsiniz.
              child: Image.asset(
                'assets/images/logo2.png', // Logo dosyasının yolunu belirtin.
                width: 55, // Logo genişliğini ayarlayabilirsiniz.
                height: 55, // Logo yüksekliğini ayarlayabilirsiniz.
              ),
            ),
            // Başlık
            const Text('Transaction Menu'),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start, // Metni sola al
              children: [
                const Icon(
                  Icons.attach_money, // Para simgesi
                  color: Colors.green, // Simge rengi
                  size: 28.0, // Simge boyutu
                ),
                const SizedBox(width:0.0), // Simge ile metin arasına boşluk eklemek için
                Text(
                  'Balance: ${globalNetBalance.toStringAsFixed(2)} TL',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Digital', // Örnek bir dijital yazı biçimi (font)
                    color: Colors.black, // Metin rengini değiştirebilirsiniz
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                childAspectRatio: 1, // Aspect ratio of the tiles
                crossAxisSpacing: 10.0, // Horizontal space between tiles
                mainAxisSpacing: 10.0, // Vertical space between tiles
              ),
              itemCount: tiles.length,
              padding: const EdgeInsets.all(20.0),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (tiles[index]['label'] == 'Borç Geçmişi') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GiveDebtPage(debtList: globalDebtList), // Pass the debtList
                        ),
                      );

                    } else {
                      // Navigate to the respective page for other tiles
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => tiles[index]['page']),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: tiles[index]['color'],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(tiles[index]['icon'], size: 40.0, color: Colors.white),
                        const SizedBox(height: 8.0),
                        Text(
                          tiles[index]['label'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}