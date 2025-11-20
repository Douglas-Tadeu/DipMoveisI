import 'package:flutter/material.dart';
import '../models/restaurante.dart';
import '../services/food_travel_service.dart';
import 'restaurante_form_screen.dart';
import 'restaurant_detail_screen.dart';

class RestauranteListScreen extends StatefulWidget {
  const RestauranteListScreen({Key? key}) : super(key: key);

  @override
  State<RestauranteListScreen> createState() => _RestauranteListScreenState();
}

class _RestauranteListScreenState extends State<RestauranteListScreen> {
  final FoodTravelService _service = FoodTravelService();

  @override
  Widget build(BuildContext context) {
    final restaurantes = _service.listarRestaurantes();

    return Scaffold(
      appBar: AppBar(title: const Text('Restaurantes')),
      body: restaurantes.isEmpty
          ? const Center(child: Text('Nenhum restaurante cadastrado.'))
          : ListView.builder(
              itemCount: restaurantes.length,
              itemBuilder: (context, index) {
                final r = restaurantes[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(r.nome),
                    subtitle: Text(r.endereco),
                    leading: r.imageUrl.isNotEmpty
                        ? Image.network(r.imageUrl, width: 50, height: 50)
                        : null,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RestaurantDetailScreen(restaurante: r),
                        ),
                      );
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RestauranteFormScreen(restaurante: r),
                              ),
                            );
                            setState(() {});
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _service.removerRestaurante(r.id);
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
            MaterialPageRoute(builder: (_) => const RestauranteFormScreen()),
          );
          setState(() {});
        },
      ),
    );
  }
}
