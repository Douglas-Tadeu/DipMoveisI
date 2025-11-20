// lib/screens/favoritar_prato.dart
import 'package:flutter/material.dart';
import '../models/favorito.dart';
import '../models/prato.dart';
import '../services/food_travel_service.dart';

class FavoritarPrato extends StatefulWidget {
  final FoodTravelService service;
  final String usuarioId;

  const FavoritarPrato({super.key, required this.service, required this.usuarioId});

  @override
  State<FavoritarPrato> createState() => _FavoritarPratoState();
}

class _FavoritarPratoState extends State<FavoritarPrato> {
  @override
  Widget build(BuildContext context) {
    final pratos = widget.service.listarPratos();
    final favoritos = widget.service.listarFavoritosDoUsuario(widget.usuarioId);

    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: ListView.builder(
        itemCount: pratos.length,
        itemBuilder: (context, index) {
          final prato = pratos[index];
          final isFavorito = favoritos.any((p) => p.id == prato.id);

          return ListTile(
            leading: Image.network(prato.imagemUrl, width: 50, height: 50, fit: BoxFit.cover),
            title: Text(prato.nome),
            trailing: IconButton(
              icon: Icon(isFavorito ? Icons.favorite : Icons.favorite_border, color: Colors.red),
              onPressed: () {
                setState(() {
                  if (isFavorito) {
                    widget.service.removerFavorito(widget.usuarioId, prato.id);
                  } else {
                    widget.service.adicionarFavorito(Favorito(usuarioId: widget.usuarioId, pratoId: prato.id));
                  }
                });
              },
            ),
          );
        },
      ),
    );
  }
}
