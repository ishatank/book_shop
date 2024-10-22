import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BMICalculatorScreen(),
    );
  }
}

class BMICalculatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Calculate your BMI here!',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                backgroundColor: Colors.black, // Optional background color
              ),
            ),
            SizedBox(height: 20), // Spacing between texts
            Text(
              'Your health is important!',
              style: TextStyle(
                fontSize: 24,
                color: Colors.green,
                color:Colors.yellow,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.blueGrey, // Optional background color for the screen
    );
  }
}
