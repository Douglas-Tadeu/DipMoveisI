import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/prato.dart';
import '../models/restaurante.dart';
import '../services/food_travel_service.dart';

class PratoFormScreen extends StatefulWidget {
  final FoodTravelService service;
  final Restaurante restaurante;
  final Prato? prato;

  const PratoFormScreen({
    super.key,
    required this.service,
    required this.restaurante,
    this.prato,
  });

  @override
  State<PratoFormScreen> createState() => _PratoFormScreenState();
}

class _PratoFormScreenState extends State<PratoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.prato != null) {
      _nomeController.text = widget.prato!.nome;
      _descricaoController.text = widget.prato!.descricao;
      _imageController.text = widget.prato!.imageUrl;
    }
  }

  void _salvar() {
    if (!_formKey.currentState!.validate()) return;

    final prato = Prato(
      id: widget.prato?.id ?? const Uuid().v4(),
      nome: _nomeController.text,
      descricao: _descricaoController.text,
      imageUrl: _imageController.text,
      restauranteId: widget.restaurante.id,
    );

    if (widget.prato == null) {
      widget.service.adicionarPrato(prato);
    } else {
      widget.service.atualizarPrato(prato);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.prato == null ? 'Adicionar Prato' : 'Editar Prato')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (v) => v!.isEmpty ? 'Informe o nome' : null,
              ),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(labelText: 'Descrição'),
              ),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(labelText: 'URL da imagem'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _salvar, child: const Text('Salvar')),
            ],
          ),
        ),
      ),
    );
  }
}
