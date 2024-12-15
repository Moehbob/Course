import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _control = TextEditingController();
  String _hintText = '';
  unit? _selectedUnit;
  String _resultText = '';

  void _convert() {
    final input = int.tryParse(_control.text) ?? 0;

    if (_selectedUnit != null) {
      if (_selectedUnit!.type == 'Km') {

        _resultText = '${input * 1000} meters';
      } else if (_selectedUnit!.type == 'kg') {

        _resultText = '${input * 1000} grams';
      } else if (_selectedUnit!.type == 'bytes') {

        _resultText = '${input * 8} bits';
      }
      setState(() {}); // Update the UI with the result
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CONVERT',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a unit:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            DropdownButton<unit>(
              value: _selectedUnit,
              hint: const Text('Select a unit'),
              onChanged: (unit? selected) {
                setState(() {
                  _selectedUnit = selected;
                  _control.clear();
                  if (selected != null) {
                    if (selected.type == 'Km') {

                      _hintText = 'Enter distance in kilometers';
                    } else if (selected.type == 'kg') {

                      _hintText = 'Enter weight in kilograms';
                    } else if (selected.type == 'bytes') {

                      _hintText = 'Enter data in bytes';
                    }
                  }
                });
              },
              items: units.map<DropdownMenuItem<unit>>((unit u) {
                return DropdownMenuItem(value: u, child: Text(u.toString()));
              }).toList(),
            ),
            const SizedBox(height: 20),
            if (_hintText.isNotEmpty)
              TextField(
                keyboardType: TextInputType.number,
                controller: _control,
                decoration: InputDecoration(
                  hintText: _hintText,
                ),
              ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            if (_resultText.isNotEmpty)
              Text(
                'Result: $_resultText',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}

class unit {
  String type;
  unit(this.type);
  @override
  String toString() {
    return type;
  }
}

List<unit> units = [
  unit('Km'),
  unit('kg'),
  unit('bytes'),
];
