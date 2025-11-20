import 'package:flutter/material.dart';
import '../services/food_travel_service.dart';
import '../models/prato.dart';
import 'avaliar_prato.dart';
import '../models/favorito.dart';

class FavoritosUsuario extends StatelessWidget {
  final FoodTravelService service;
  final String usuarioId;

  const FavoritosUsuario({super.key, required this.service, required this.usuarioId});

  @override
  Widget build(BuildContext context) {
    final favoritos = service.listarFavoritosDoUsuario(usuarioId);

    return Scaffold(
      appBar: AppBar(title: const Text('Meus Favoritos')),
      body: favoritos.isEmpty
          ? const Center(child: Text('Você ainda não favoritou nenhum prato.'))
          : ListView.builder(
              itemCount: favoritos.length,
              itemBuilder: (context, index) {
                final prato = favoritos[index];
                final media = service.calcularMediaAvaliacoes(prato.id).toStringAsFixed(1);

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: Image.network(
                      prato.imagemUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(prato.nome),
                    subtitle: Text('Média: $media'),
                    trailing: IconButton(
                      icon: const Icon(Icons.star),
                      onPressed: () {
                        // Avaliar prato a partir dos favoritos
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AvaliarPrato(
                              service: service,
                              usuarioId: usuarioId,
                              pratoId: prato.id,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
