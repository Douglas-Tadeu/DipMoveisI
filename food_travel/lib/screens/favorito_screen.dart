import 'package:flutter/material.dart';
import '../models/prato.dart';
import '../services/food_travel_service.dart';

class FavoritoScreen extends StatefulWidget {
  final String usuarioId;
  const FavoritoScreen({Key? key, required this.usuarioId}) : super(key: key);

  @override
  State<FavoritoScreen> createState() => _FavoritoScreenState();
}

class _FavoritoScreenState extends State<FavoritoScreen> {
  final FoodTravelService _service = FoodTravelService();

  @override
  Widget build(BuildContext context) {
    final favoritos = _service.listarFavoritosDoUsuario(widget.usuarioId);

    return Scaffold(
      appBar: AppBar(title: const Text('Meus Favoritos')),
      body: favoritos.isEmpty
          ? const Center(child: Text('Nenhum favorito.'))
          : ListView.builder(
              itemCount: favoritos.length,
              itemBuilder: (context, index) {
                final p = favoritos[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(p.nome),
                    subtitle: Text('R\$ ${p.preco.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _service.removerFavorito(widget.usuarioId, p.id);
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
