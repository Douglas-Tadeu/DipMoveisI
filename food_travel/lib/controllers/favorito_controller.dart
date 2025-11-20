import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class FavoritoController {
  Future<List<dynamic>> listarFavoritos(String usuarioId) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/favoritos/$usuarioId");

    final response = await http.get(url);
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> favoritar(String usuarioId, String pratoId) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/favoritos");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "usuarioId": usuarioId,
        "pratoId": pratoId,
      }),
    );

    return jsonDecode(response.body);
  }
}
