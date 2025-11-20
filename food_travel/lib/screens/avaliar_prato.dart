// lib/screens/avaliar_prato.dart
import 'package:flutter/material.dart';
import '../models/avaliacao.dart';
import '../services/food_travel_service.dart';

class AvaliarPrato extends StatefulWidget {
  final FoodTravelService service;
  final String usuarioId;
  final String pratoId;

  const AvaliarPrato({super.key, required this.service, required this.usuarioId, required this.pratoId});

  @override
  State<AvaliarPrato> createState() => _AvaliarPratoState();
}

class _AvaliarPratoState extends State<AvaliarPrato> {
  double nota = 0;
  final comentarioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Avaliar Prato')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Nota: ${nota.toStringAsFixed(1)}', style: const TextStyle(fontSize: 18)),
            Slider(
              value: nota,
              onChanged: (v) => setState(() => nota = v),
              min: 0,
              max: 5,
              divisions: 10,
            ),
            TextField(
              controller: comentarioController,
              decoration: const InputDecoration(labelText: 'Comentário'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.service.adicionarAvaliacao(Avaliacao(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  usuarioId: widget.usuarioId,
                  pratoId: widget.pratoId,
                  nota: nota,
                  comentario: comentarioController.text,
                  data: DateTime.now(),
                ));
                Navigator.pop(context);
              },
              child: const Text('Salvar Avaliação'),
            ),
          ],
        ),
      ),
    );
  }
}
