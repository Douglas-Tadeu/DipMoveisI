import 'package:flutter/material.dart';
import '../services/food_travel_service.dart';
import '../models/favorito.dart';
import 'avaliar_prato.dart';
import 'favoritar_prato.dart';

class ListaPratos extends StatelessWidget {
  final FoodTravelService service;
  final String restauranteId;

  const ListaPratos({super.key, required this.service, required this.restauranteId});

  @override
  Widget build(BuildContext context) {
    final pratos = service.listarPratosPorRestaurante(restauranteId);

    return Scaffold(
      appBar: AppBar(title: const Text('Pratos')),
      body: ListView.builder(
        itemCount: pratos.length,
        itemBuilder: (context, index) {
          final prato = pratos[index];
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
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Botão Avaliar
                  IconButton(
                    icon: const Icon(Icons.star),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AvaliarPrato(
                            service: service,
                            usuarioId: '1', // usuário de teste
                            pratoId: prato.id,
                          ),
                        ),
                      );
                    },
                  ),
                  // Botão Favoritar
                  IconButton(
                    icon: Icon(
                      service.listarFavoritosDoUsuario('1').any((p) => p.id == prato.id)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      if (service.listarFavoritosDoUsuario('1').any((p) => p.id == prato.id)) {
                        service.removerFavorito('1', prato.id);
                      } else {
                        service.adicionarFavorito(Favorito(usuarioId: '1', pratoId: prato.id));
                      }
                      (context as Element).markNeedsBuild(); // força atualizar a tela
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
