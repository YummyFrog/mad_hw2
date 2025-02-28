import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  String _operator = '';
  double _firstOperand = 0;
  double _secondOperand = 0;
  bool _isOperatorPressed = false;

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _display = '0';
        _operator = '';
        _firstOperand = 0;
        _secondOperand = 0;
        _isOperatorPressed = false;
      } else if (buttonText == '+' || buttonText == '-' || buttonText == '*' || buttonText == '/') {
        if (_operator.isNotEmpty) {
          _calculateResult();
        }
        _operator = buttonText;
        _firstOperand = double.parse(_display);
        _isOperatorPressed = true;
      } else if (buttonText == '=') {
        _calculateResult();
        _operator = '';
        _isOperatorPressed = false;
      } else {
        if (_display == '0' || _isOperatorPressed) {
          _display = buttonText;
          _isOperatorPressed = false;
        } else {
          _display += buttonText;
        }
      }
    });
  }

  void _calculateResult() {
    _secondOperand = double.parse(_display);
    switch (_operator) {
      case '+':
        _display = (_firstOperand + _secondOperand).toString();
        break;
      case '-':
        _display = (_firstOperand - _secondOperand).toString();
        break;
      case '*':
        _display = (_firstOperand * _secondOperand).toString();
        break;
      case '/':
        if (_secondOperand == 0) {
          _display = 'Error';
        } else {
          _display = (_firstOperand / _secondOperand).toString();
        }
        break;
      default:
        break;
    }
    _firstOperand = double.parse(_display);
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _display,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Divider(),
          Column(
            children: [
              Row(
                children: [
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('/'),
                ],
              ),
              Row(
                children: [
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('*'),
                ],
              ),
              Row(
                children: [
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildButton('-'),
                ],
              ),
              Row(
                children: [
                  _buildButton('0'),
                  _buildButton('C'),
                  _buildButton('='),
                  _buildButton('+'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}