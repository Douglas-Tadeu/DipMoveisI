import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class AuthController {
  Future<Map<String, dynamic>> login(String email, String senha) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/auth/login");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "senha": senha}),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        // backend retorna { token, usuario: { id, nome, email, ... } }
        final usuario = body["usuario"] ?? body["user"];
        final token = body["token"];

        return {
          "success": true,
          "message": "Login bem-sucedido",
          "user": usuario,
          "token": token,
        };
      } else if (response.statusCode == 401 || response.statusCode == 400) {
        final body = response.body.isNotEmpty ? jsonDecode(response.body) : null;
        final msg = body != null ? (body["error"] ?? body["message"] ?? "Credenciais inválidas") : "Credenciais inválidas";
        return {"success": false, "message": msg};
      } else {
        return {"success": false, "message": "Erro no servidor: ${response.statusCode}"};
      }
    } catch (e) {
      return {"success": false, "message": "Erro de conexão: $e"};
    }
  }

  Future<Map<String, dynamic>> register(String nome, String email, String senha) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/auth/register");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"nome": nome, "email": email, "senha": senha}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = jsonDecode(response.body);
        final usuario = body["usuario"] ?? body["user"];
        final token = body["token"];

        return {
          "success": true,
          "message": "Conta criada com sucesso!",
          "user": usuario,
          "token": token,
        };
      } else if (response.statusCode == 400) {
        final body = response.body.isNotEmpty ? jsonDecode(response.body) : null;
        final msg = body != null ? (body["error"] ?? body["message"] ?? "Erro no cadastro") : "Erro no cadastro";
        return {"success": false, "message": msg};
      } else {
        return {"success": false, "message": "Erro no servidor: ${response.statusCode}"};
      }
    } catch (e) {
      return {"success": false, "message": "Erro de conexão: $e"};
    }
  }
}
