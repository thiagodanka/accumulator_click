import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Acumulador de Valor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const AccumulatorScreen(),
    );
  }
}

class AccumulatorScreen extends StatefulWidget {
  const AccumulatorScreen({super.key});

  @override
  State<AccumulatorScreen> createState() => _AccumulatorScreenState();
}

class _AccumulatorScreenState extends State<AccumulatorScreen> {
  int _clicks = 0;
  double _total = 0.0;

  // Confetti Controller
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    // Initialize the confetti controller
    _confettiController = ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _addAmount() {
    setState(() {
      _clicks++;
      _total += 3.0;

      // Trigger confetti when total exceeds 100
      if (_total > 100) {
        _confettiController.play();
      }
    });
  }

  void _reset() {
    setState(() {
      _clicks = 0;
      _total = 0.0;
      _confettiController.stop(); // Stop the confetti animation on reset
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acumulador de Valor"),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Cada clique equivale a R\$ 3,00',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Bem-vindo ao Acumulador de Valor!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCard("Valor Total", "R\$ ${_total.toStringAsFixed(2)}"),
                    const SizedBox(width: 10),
                    _buildCard("Cliques", "$_clicks"),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  _clicks == 0
                      ? "Clique no botão abaixo para começar!"
                      : "Continue clicando para acumular mais!",
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _addAmount,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  ),
                  child: const Text(
                    "Adicionar",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _reset,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  ),
                  child: const Text(
                    "Zerar",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
            // Confetti Widget
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive, // Confetti in all directions
                numberOfParticles: 20, // Number of particles
                maxBlastForce: 20, // Maximum blast force
                minBlastForce: 10, // Minimum blast force
                gravity: 0.1, // Gravity effect on confetti
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, String value) {
    return Card(
      elevation: 4,
      color: Colors.blue.shade50,
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 150,
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
