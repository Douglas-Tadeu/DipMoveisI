import 'package:flutter/material.dart';
import '../models/prato.dart';
import '../models/restaurante.dart';
import '../services/food_travel_service.dart';
import 'prato_form_screen.dart';

class PratoListScreen extends StatefulWidget {
  final FoodTravelService service;
  final Restaurante restaurante;

  const PratoListScreen({super.key, required this.service, required this.restaurante});

  @override
  State<PratoListScreen> createState() => _PratoListScreenState();
}

class _PratoListScreenState extends State<PratoListScreen> {
  late List<Prato> pratos;

  @override
  void initState() {
    super.initState();
    pratos = widget.service.listarPratosPorRestaurante(widget.restaurante.id);
  }

  void _atualizarLista() {
    setState(() {
      pratos = widget.service.listarPratosPorRestaurante(widget.restaurante.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pratos de ${widget.restaurante.nome}')),
      body: ListView.builder(
        itemCount: pratos.length,
        itemBuilder: (context, index) {
          final p = pratos[index];
          return ListTile(
            leading: p.imageUrl.isNotEmpty
                ? Image.network(p.imageUrl, width: 50, height: 50)
                : const Icon(Icons.fastfood),
            title: Text(p.nome),
            subtitle: Text(p.descricao),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PratoFormScreen(
                          service: widget.service,
                          restaurante: widget.restaurante,
                          prato: p,
                        ),
                      ),
                    );
                    _atualizarLista();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    widget.service.removerPrato(p.id);
                    _atualizarLista();
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PratoFormScreen(service: widget.service, restaurante: widget.restaurante),
            ),
          );
          _atualizarLista();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
