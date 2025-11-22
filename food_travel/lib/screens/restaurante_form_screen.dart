import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/restaurante.dart';
import '../services/food_travel_service.dart';

class RestauranteFormScreen extends StatefulWidget {
  final FoodTravelService service;
  final Restaurante? restaurante;

  const RestauranteFormScreen({
    super.key,
    required this.service,
    this.restaurante,
  });

  @override
  State<RestauranteFormScreen> createState() => _RestauranteFormScreenState();
}

class _RestauranteFormScreenState extends State<RestauranteFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _imageController = TextEditingController();

  String? _usuarioId; // ← DONO DO RESTAURANTE

  @override
  void initState() {
    super.initState();
    _loadUsuarioId();

    if (widget.restaurante != null) {
      _nomeController.text = widget.restaurante!.nome;
      _enderecoController.text = widget.restaurante!.endereco;
      _imageController.text = widget.restaurante!.imageUrl;
      _usuarioId = widget.restaurante!.usuarioId; // preserva dono em edição
    }
  }

  Future<void> _loadUsuarioId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _usuarioId = prefs.getString('usuarioId');
    });
  }

  void _salvar() {
    if (!_formKey.currentState!.validate()) return;

    if (_usuarioId == null || _usuarioId!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro: usuário não encontrado.")),
      );
      return;
    }

    final id = widget.restaurante?.id ?? const Uuid().v4();

    final restaurante = Restaurante(
      id: id,
      usuarioId: _usuarioId!,   // ← salva dono automaticamente
      nome: _nomeController.text,
      endereco: _enderecoController.text,
      imageUrl: _imageController.text,
    );

    if (widget.restaurante == null) {
      widget.service.adicionarRestaurante(restaurante);
    } else {
      widget.service.atualizarRestaurante(restaurante);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurante == null
            ? "Adicionar Restaurante"
            : "Editar Restaurante"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: "Nome"),
                validator: (v) => v!.isEmpty ? "Informe o nome" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _enderecoController,
                decoration: const InputDecoration(labelText: "Endereço"),
                validator: (v) => v!.isEmpty ? "Informe o endereço" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(labelText: "URL da imagem"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvar,
                child: const Text("Salvar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
