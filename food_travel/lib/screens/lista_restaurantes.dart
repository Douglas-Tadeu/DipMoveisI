import 'package:flutter/material.dart';
import '../services/food_travel_service.dart';
import 'lista_pratos.dart';
import 'favoritos_usuario.dart';

class ListaRestaurantes extends StatelessWidget {
  final FoodTravelService service;

  const ListaRestaurantes({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final restaurantes = service.listarRestaurantes();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurantes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritosUsuario(
                    service: service,
                    usuarioId: '1',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: restaurantes.length,
        itemBuilder: (context, index) {
          final restaurante = restaurantes[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListaPratos(
                    service: service,
                    restauranteId: restaurante.id,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 3,
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  // --- IMAGEM GRANDE COM BORDA ARREDONDADA ---
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(
                      restaurante.imagemUrl,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 160,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.image_not_supported, size: 40),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // -- TÍTULO + FAVORITO --
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                restaurante.nome,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Icon(
                              Icons.favorite_border,
                              color: Colors.red,
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        // -- ENDEREÇO --
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                restaurante.endereco,
                                style: const TextStyle(color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // -- AVALIAÇÃO COM ESTRELAS FAKE (ENFEITE)
                        Row(
                          children: const [
                            Icon(Icons.star, color: Colors.amber, size: 18),
                            Icon(Icons.star, color: Colors.amber, size: 18),
                            Icon(Icons.star, color: Colors.amber, size: 18),
                            Icon(Icons.star_half, color: Colors.amber, size: 18),
                            Icon(Icons.star_border, color: Colors.amber, size: 18),
                          ],
                        ),
                      ],
                    ),
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
