import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/usuario.dart';
import '../services/food_travel_service.dart';

class UsuarioFormScreen extends StatefulWidget {
  final FoodTravelService service;
  final Usuario? usuario;

  const UsuarioFormScreen({super.key, required this.service, this.usuario});

  @override
  State<UsuarioFormScreen> createState() => _UsuarioFormScreenState();
}

class _UsuarioFormScreenState extends State<UsuarioFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.usuario != null) {
      _nomeController.text = widget.usuario!.nome;
      _emailController.text = widget.usuario!.email;
      _senhaController.text = widget.usuario!.senha;
    }
  }

  void _salvar() {
    if (!_formKey.currentState!.validate()) return;

    final usuario = Usuario(
      id: widget.usuario?.id ?? const Uuid().v4(),
      nome: _nomeController.text,
      email: _emailController.text,
      senha: _senhaController.text,
    );

    if (widget.usuario == null) {
      widget.service.adicionarUsuario(usuario);
    } else {
      widget.service.atualizarUsuario(usuario);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.usuario == null ? 'Adicionar Usuário' : 'Editar Usuário')),
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
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (v) => v!.isEmpty ? 'Informe o email' : null,
              ),
              TextFormField(
                controller: _senhaController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (v) => v!.isEmpty ? 'Informe a senha' : null,
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
