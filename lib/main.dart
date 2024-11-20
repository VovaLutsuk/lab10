import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Preview App',
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController _textController = TextEditingController();
  double _fontSize = 16.0;

  void _showDialog(String message, String assetPath) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                assetPath, // Показує іконку робота
                width: 60,
                height: 60,
              ),
              const SizedBox(height: 10),
              Text(message),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Screen')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: 'Enter text',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  const Text('Adjust font size'),
                  Slider(
                    value: _fontSize,
                    min: 10.0,
                    max: 50.0,
                    divisions: 40,
                    label: '${_fontSize.toInt()}',
                    onChanged: (newValue) {
                      setState(() {
                        _fontSize = newValue;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  final text = _textController.text;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecondScreen(
                        text: text,
                        fontSize: _fontSize,
                      ),
                    ),
                  ).then((result) {
                    if (result == 'ok') {
                      _showDialog('Cool!', 'assets/robot.webp');
                    } else if (result == 'cancel') {
                      _showDialog('Let’s try something else', 'assets/robot.webp');
                    } else {
                      _showDialog('Don\'t know what to say', 'assets/robot.webp');
                    }
                  });
                },
                child: const Text('Preview'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final String text;
  final double fontSize;

  const SecondScreen({required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: fontSize),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'ok');
              },
              child: const Text('Ok'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'cancel');
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
