import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class RestauranteController {
  Future<List<dynamic>> listarRestaurantes() async {
    final url = Uri.parse("${ApiConfig.baseUrl}/restaurantes");

    final response = await http.get(url);
    return jsonDecode(response.body);
  }
}
