import 'package:flutter/material.dart';
import '../models/usuario.dart';
import '../models/restaurante.dart';
import '../models/prato.dart';
import '../models/avaliacao.dart';
import '../models/favorito.dart';


class HomePage extends StatelessWidget {
const HomePage({super.key});


// dados de exemplo locais (mock)
List<Restaurante> _mockRestaurantes() => [
Restaurante(
id: 'r1', nome: 'Sabor do Mundo', cidade: 'Lisboa', imagem: '',
pratos: [Prato(id: 'p1', nome: 'Bacalhau', preco: 25.0)],
avaliacoes: [Avaliacao(id: 'a1', usuarioId: 'u1', nota: 4.5)],
),
Restaurante(
id: 'r2', nome: 'Cozinha Nômade', cidade: 'Rio de Janeiro', imagem: '',
pratos: [Prato(id: 'p2', nome: 'Feijoada', preco: 18.0)],
avaliacoes: [Avaliacao(id: 'a2', usuarioId: 'u2', nota: 4.2)],
),
];


@override
Widget build(BuildContext context) {
final restaurantes = _mockRestaurantes();
return Scaffold(
appBar: AppBar(title: const Text('FoodTravel')),
body: ListView.builder(
itemCount: restaurantes.length,
itemBuilder: (context, index) {
final r = restaurantes[index];
return ListTile(
title: Text(r.nome),
subtitle: Text('${r.cidade} · ⭐ ${r.mediaAvaliacao.toStringAsFixed(1)}'),
onTap: () => showDialog(context: context, builder: (_) => AlertDialog(
title: Text(r.nome),
content: Text('Pratos: ' + r.pratos.map((p) => p.nome).join(', ')),
)),
);
},
),
);
}
}