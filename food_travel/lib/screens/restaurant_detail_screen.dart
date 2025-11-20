import 'package:flutter/material.dart';
import '../models/restaurante.dart';
import '../models/prato.dart';
import '../services/food_travel_service.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final Restaurante restaurante;
  final FoodTravelService _service = FoodTravelService();

  RestaurantDetailScreen({Key? key, required this.restaurante})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Prato> pratos =
        _service.listarPratosPorRestaurante(restaurante.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurante.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              restaurante.nome,
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              restaurante.endereco,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            const Text(
              'Pratos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: pratos.isEmpty
                  ? const Center(child: Text('Nenhum prato cadastrado.'))
                  : ListView.builder(
                      itemCount: pratos.length,
                      itemBuilder: (context, index) {
                        final prato = pratos[index];
                        final media = _service.calcularMediaAvaliacoes(prato.id);

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                prato.imageUrl,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.fastfood),
                              ),
                            ),
                            title: Text(prato.nome),
                            subtitle: Text(
                              'Média de avaliações: ${media.toStringAsFixed(1)}',
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
