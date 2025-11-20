import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class AvaliacaoController {
  Future<List<dynamic>> listarAvaliacoes(String pratoId) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/avaliacoes/$pratoId");

    final response = await http.get(url);
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> avaliar({
    required String usuarioId,
    required String pratoId,
    required double nota,
    required String comentario,
  }) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/avaliacoes");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "usuarioId": usuarioId,
        "pratoId": pratoId,
        "nota": nota,
        "comentario": comentario,
      }),
    );

    return jsonDecode(response.body);
  }
}
