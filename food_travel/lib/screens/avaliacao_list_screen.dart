import 'package:flutter/material.dart';
import '../models/avaliacao.dart';
import '../models/prato.dart';
import '../services/food_travel_service.dart';
import 'avaliacao_form_screen.dart';

class AvaliacaoListScreen extends StatefulWidget {
  final Prato prato;
  const AvaliacaoListScreen({Key? key, required this.prato}) : super(key: key);

  @override
  State<AvaliacaoListScreen> createState() => _AvaliacaoListScreenState();
}

class _AvaliacaoListScreenState extends State<AvaliacaoListScreen> {
  final FoodTravelService _service = FoodTravelService();

  @override
  Widget build(BuildContext context) {
    final avaliacoes = _service.listarAvaliacoesPorPrato(widget.prato.id);

    return Scaffold(
      appBar: AppBar(title: Text('Avaliações de ${widget.prato.nome}')),
      body: avaliacoes.isEmpty
          ? const Center(child: Text('Nenhuma avaliação cadastrada.'))
          : ListView.builder(
              itemCount: avaliacoes.length,
              itemBuilder: (context, index) {
                final a = avaliacoes[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text('Nota: ${a.nota}'),
                    subtitle: Text(a.comentario),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AvaliacaoFormScreen(prato: widget.prato, avaliacao: a),
                              ),
                            );
                            setState(() {});
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _service.removerAvaliacao(a.id);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AvaliacaoFormScreen(prato: widget.prato),
            ),
          );
          setState(() {});
        },
      ),
    );
  }
}
