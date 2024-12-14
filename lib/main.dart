import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(TicnoDetaRecoveryApp());
}

class TicnoDetaRecoveryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticno Deta Recovery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
