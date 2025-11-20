import 'package:flutter/material.dart';
import '../models/usuario.dart';
import '../services/food_travel_service.dart';
import 'usuario_form_screen.dart';

class UsuarioListScreen extends StatefulWidget {
  final FoodTravelService service;
  const UsuarioListScreen({super.key, required this.service});

  @override
  State<UsuarioListScreen> createState() => _UsuarioListScreenState();
}

class _UsuarioListScreenState extends State<UsuarioListScreen> {
  late List<Usuario> usuarios;

  @override
  void initState() {
    super.initState();
    usuarios = widget.service.listarUsuarios();
  }

  void _atualizarLista() {
    setState(() {
      usuarios = widget.service.listarUsuarios();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usuários')),
      body: ListView.builder(
        itemCount: usuarios.length,
        itemBuilder: (context, index) {
          final u = usuarios[index];
          return ListTile(
            title: Text(u.nome),
            subtitle: Text(u.email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UsuarioFormScreen(service: widget.service, usuario: u),
                      ),
                    );
                    _atualizarLista();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    widget.service.removerUsuario(u.id);
                    _atualizarLista();
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => UsuarioFormScreen(service: widget.service),
            ),
          );
          _atualizarLista();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
