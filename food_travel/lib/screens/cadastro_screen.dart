import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  final AuthController auth = AuthController();

  Future<void> _cadastrar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    final sucesso = await auth.register(
      _nomeController.text.trim(),
      _emailController.text.trim(),
      _senhaController.text.trim(),
    );

    setState(() => _loading = false);

    if (!sucesso) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao cadastrar")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Conta criada com sucesso!")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Criar Conta")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
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
                controller: _emailController,
                decoration: const InputDecoration(labelText: "E-mail"),
                validator: (v) => v!.isEmpty ? "Informe o e-mail" : null,
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: _senhaController,
                decoration: const InputDecoration(labelText: "Senha"),
                obscureText: true,
                validator: (v) => v!.isEmpty ? "Informe a senha" : null,
              ),
              const SizedBox(height: 20),

              _loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      onPressed: _cadastrar,
                      child: const Text("Cadastrar"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
