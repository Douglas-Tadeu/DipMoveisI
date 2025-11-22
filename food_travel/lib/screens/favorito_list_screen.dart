import 'package:flutter/material.dart';
import '../models/usuario.dart';
import '../services/food_travel_service.dart';

class FavoritoListScreen extends StatelessWidget {
  final FoodTravelService service;
  final Usuario usuario;

  const FavoritoListScreen({
    super.key,
    required this.service,
    required this.usuario,
  });

  @override
  Widget build(BuildContext context) {
    final favoritos = service.listarFavoritosDoUsuario(usuario.id);

    return Scaffold(
      appBar: AppBar(title: const Text("Favoritos")),
      body: favoritos.isEmpty
          ? const Center(child: Text("Nenhum favorito adicionado"))
          : ListView.builder(
              itemCount: favoritos.length,
              itemBuilder: (context, index) {
                final prato = favoritos[index];
                return ListTile(
                  title: Text(prato.nome),
                  subtitle: Text(prato.descricao),
                );
              },
            ),
    );
  }
}
