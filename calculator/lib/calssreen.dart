import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
//abeer abu lehia
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'آلة حاسبة',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> symbols = [
    'C',
    'Del',
    '%',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'Ans',
    '=',
  ];

  String input = '';
  String output = '';

  void onButtonClick(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        output = '';
      } else if (value == 'Del') {
        if (input.isNotEmpty) input = input.substring(0, input.length - 1);
      } else if (value == '=') {
        try {
          String finalInput = input.replaceAll('%', '/100');
          Parser p = Parser();
          Expression exp = p.parse(finalInput);
          ContextModel cm = ContextModel();
          double result = exp.evaluate(EvaluationType.REAL, cm);
          output = result.toString();
        } catch (e) {
          output = 'Error';
        }
      } else {
        input += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Text(
                input,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 36,
                  color: Color.fromARGB(204, 85, 84, 84),
                ),
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.topRight,
            child: Text(
              output,
              textAlign: TextAlign.right,

              style: const TextStyle(
                fontSize: 36,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),

          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),

              padding: const EdgeInsets.all(8),
              itemCount: symbols.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 33,
                mainAxisSpacing: 3,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                String symbol = symbols[index];

                return GestureDetector(
                  onTap: () => onButtonClick(symbol),
                  child: Container(
                    decoration: BoxDecoration(),
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      symbol,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
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
