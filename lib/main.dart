import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';

  void _addToExpression(String value) {
    setState(() {
      _expression += value;
    });
  }

  void _clearExpression() {
    setState(() {
      _expression = '';
      _result = '';
    });
  }

  void _evaluateExpression() {
    Parser p = Parser();
    Expression exp = p.parse(_expression);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    setState(() {
      _result = eval.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              color: Color.alphaBlend(Colors.black12, Colors.blueGrey),
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _expression,
                style: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Color.alphaBlend(Colors.black12, Colors.blueGrey),
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _result,
                style: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            color: Color.alphaBlend(Colors.black12, Colors.blueGrey),
            child: Row(
              children: [
                _buildRoundButton('7'),
                _buildRoundButton('8'),
                _buildRoundButton('9'),
                _buildOperatorButton('/'),
              ],
            ),
          ),
          Container(
            color: Color.alphaBlend(Colors.black12, Colors.blueGrey),
            child: Row(
              children: [
                _buildRoundButton('4'),
                _buildRoundButton('5'),
                _buildRoundButton('6'),
                _buildOperatorButton('*'),
              ],
            ),
          ),
          Container(
            color: Color.alphaBlend(Colors.black12, Colors.blueGrey),
            child: Row(
              children: [
                _buildRoundButton('1'),
                _buildRoundButton('2'),
                _buildRoundButton('3'),
                _buildOperatorButton('-'),
              ],
            ),
          ),
          Container(
            color: Color.alphaBlend(Colors.black12, Colors.blueGrey),
            child: Row(
              children: [
                _buildRoundButton('0'),
                _buildRoundButton('.'),
                _buildOperatorButton('+'),
                _buildActionButton('C'),
              ],
            ),
          ),
          Container(
              color: Color.alphaBlend(Colors.black12, Colors.blueGrey),
              child: _buildActionButton('=')),
        ],
      ),
    );
  }

  Widget _buildRoundButton(String value) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _addToExpression(value),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black45,
            shape: CircleBorder(),
            padding: EdgeInsets.all(24.0),
            textStyle: TextStyle(fontSize: 24.0),
          ),
          child: Text(value),
        ),
      ),
    );
  }

  Widget _buildOperatorButton(String operator) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _addToExpression(operator),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black12,
            shape: CircleBorder(),
            padding: EdgeInsets.all(24.0),
            textStyle: TextStyle(fontSize: 24.0),
          ),
          child: Text(operator),
        ),
      ),
    );
  }

  Widget _buildActionButton(String action) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            if (action == '=') {
              _evaluateExpression();
            } else {
              _clearExpression();
            }
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.brown.shade300,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(24.0),
            textStyle: TextStyle(fontSize: 24.0),
          ),
          child: Text(action),
        ),
      ),
    );
  }
}
