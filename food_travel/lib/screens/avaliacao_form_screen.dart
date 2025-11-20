import 'package:flutter/material.dart';
import '../models/avaliacao.dart';
import '../models/prato.dart';
import '../models/usuario.dart';
import '../services/food_travel_service.dart';
import 'package:uuid/uuid.dart';

class AvaliacaoFormScreen extends StatefulWidget {
  final Avaliacao? avaliacao;
  final Prato prato;

  const AvaliacaoFormScreen({Key? key, this.avaliacao, required this.prato}) : super(key: key);

  @override
  State<AvaliacaoFormScreen> createState() => _AvaliacaoFormScreenState();
}

class _AvaliacaoFormScreenState extends State<AvaliacaoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final FoodTravelService _service = FoodTravelService();

  late TextEditingController _notaController;
  late TextEditingController _comentarioController;
  late String _usuarioId;

  @override
  void initState() {
    super.initState();
    _notaController = TextEditingController(text: widget.avaliacao?.nota.toString() ?? '');
    _comentarioController = TextEditingController(text: widget.avaliacao?.comentario ?? '');
    _usuarioId = widget.avaliacao?.usuarioId ?? ''; // Para simplificação, escolha usuário fixo ou dropdown depois
  }

  @override
  void dispose() {
    _notaController.dispose();
    _comentarioController.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      final nota = double.tryParse(_notaController.text) ?? 0.0;
      if (widget.avaliacao == null) {
        _service.adicionarAvaliacao(
          Avaliacao(
            id: const Uuid().v4(),
            pratoId: widget.prato.id,
            usuarioId: _usuarioId.isNotEmpty ? _usuarioId : 'usuario1', // default para teste
            nota: nota,
            comentario: _comentarioController.text,
          ),
        );
      } else {
        _service.atualizarAvaliacao(
          Avaliacao(
            id: widget.avaliacao!.id,
            pratoId: widget.prato.id,
            usuarioId: _usuarioId,
            nota: nota,
            comentario: _comentarioController.text,
          ),
        );
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdicao = widget.avaliacao != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdicao ? 'Editar Avaliação' : 'Nova Avaliação')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _notaController,
                decoration: const InputDecoration(labelText: 'Nota'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Informe a nota' : null,
              ),
              TextFormField(
                controller: _comentarioController,
                decoration: const InputDecoration(labelText: 'Comentário'),
                validator: (value) => value!.isEmpty ? 'Informe o comentário' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvar,
                child: Text(isEdicao ? 'Atualizar' : 'Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
