import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class AuthController {
  Future<Map<String, dynamic>> login(String email, String senha) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/auth/login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "senha": senha,
      }),
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> registrar(String nome, String email, String senha) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/auth/register");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nome": nome,
        "email": email,
        "senha": senha,
      }),
    );

    return jsonDecode(response.body);
  }
}
