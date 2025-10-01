import 'package:flutter/material.dart';

void main() {
  runApp(const IMCApp());
}

class IMCApp extends StatelessWidget {
  const IMCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const IMCPage(),
    );
  }
}

class IMCPage extends StatefulWidget {
  const IMCPage({super.key});

  @override
  State<IMCPage> createState() => _IMCPageState();
}

class _IMCPageState extends State<IMCPage> {
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();

  String resultado = "";

  // Calcule o IMC usando uma função -------------------------------------------------------------------------
  double calcularIMC(double peso, double alturaCm) {
    double alturaM = alturaCm / 100; // converte cm pra metros
    return peso / (alturaM * alturaM);
  }

  // Mostre o resultado com classificação -------------------------------------------------------------------------
  String classificarIMC(double imc) {
    if (imc < 18.5) return "Abaixo do peso";
    if (imc < 24.9) return "Normal";
    if (imc < 29.9) return "Sobrepeso";
    return "Obesidade";
  }

  void calcular() {
    final String pesoText = pesoController.text;
    final String alturaText = alturaController.text;

    // Valide se os valores são válidos -------------------------------------------------------------------------
    if (pesoText.isEmpty || alturaText.isEmpty) {
      setState(() {
        resultado = "Preencha todos os campos!";
      });
      return;
    }

    final double? peso = double.tryParse(pesoText);
    final double? alturaCm = double.tryParse(alturaText);

    if (peso == null || alturaCm == null || alturaCm <= 0) {
      setState(() {
        resultado = "Valores inválidos!";
      });
      return;
    }

    final double imc = calcularIMC(peso, alturaCm);
    final String classificacao = classificarIMC(imc);

    // Mostre o resultado com classificacao -------------------------------------------------------------------------
    setState(() {
      resultado = "IMC: ${imc.toStringAsFixed(2)}\n$classificacao";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculadora de IMC")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Receba peso -------------------------------------------------------------------------
            TextField(
              controller: pesoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Peso (kg)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            // Receba altura -------------------------------------------------------------------------
            TextField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Altura (cm)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: calcular,
              child: const Text("Calcular"),
            ),
            const SizedBox(height: 20),

            // Mostre o resultado -------------------------------------------------------------------------
            Text(
              resultado,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
