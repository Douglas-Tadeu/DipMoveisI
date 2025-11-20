import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class UsuarioController {
  Future<List<dynamic>> listarUsuarios() async {
    final url = Uri.parse("${ApiConfig.baseUrl}/usuarios");

    final response = await http.get(url);
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> buscarUsuario(String id) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/usuarios/$id");

    final response = await http.get(url);
    return jsonDecode(response.body);
  }
}
