import 'package:flutter/material.dart';
import '../models/restaurante.dart';
import '../services/food_travel_service.dart';
import 'restaurante_form_screen.dart';
import 'prato_list_screen.dart';

class RestauranteListScreen extends StatefulWidget {
  final FoodTravelService service;

  const RestauranteListScreen({super.key, required this.service});

  @override
  State<RestauranteListScreen> createState() => _RestauranteListScreenState();
}

class _RestauranteListScreenState extends State<RestauranteListScreen> {
  late List<Restaurante> restaurantes;

  @override
  void initState() {
    super.initState();
    restaurantes = widget.service.listarRestaurantes();
  }

  void _atualizarLista() {
    setState(() {
      restaurantes = widget.service.listarRestaurantes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Restaurantes")),
      body: ListView.builder(
        itemCount: restaurantes.length,
        itemBuilder: (context, index) {
          final r = restaurantes[index];
          return ListTile(
            leading: r.imageUrl.isNotEmpty
                ? Image.network(r.imageUrl, width: 50, height: 50, fit: BoxFit.cover)
                : const Icon(Icons.restaurant),
            title: Text(r.nome),
            subtitle: Text(r.endereco),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PratoListScreen(service: widget.service, restaurante: r),
              ),
            ).then((_) => _atualizarLista()),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RestauranteFormScreen(service: widget.service, restaurante: r),
                    ),
                  ).then((_) => _atualizarLista()),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    widget.service.removerRestaurante(r.id);
                    _atualizarLista();
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => RestauranteFormScreen(service: widget.service)),
        ).then((_) => _atualizarLista()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
