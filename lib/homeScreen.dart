import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      backgroundColor: Colors.white, // Change the background color to blue or any color you prefer.
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logo2.png', // Replace with the path to your image.
              width: 300, // Adjust the width as needed.
              height: 300, // Adjust the height as needed.
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Debt Tracker Asisstant',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
