import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/models/user.dart';

class ApiService {
  final String baseUrl = "http://10.0.2.2:3000/";

  Future<User?> registerUser(User user) async {
    final response = await http.post(
      Uri.parse(baseUrl + "api/users/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toJson()),
    );

    // Verifica se o status code é 201 (usuário criado com sucesso)
    if (response.statusCode == 200|| response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body)); // Retorna o usuário com ID
    } else if (response.statusCode == 409) {
      // O e-mail já está registrado
      throw Exception('Email ja esta cadastrado');
    } else {
      // Outros erros
      return null;
    }
  }

  Future<User?> loginUser(Map<String, String> loginRequest) async {
    final response = await http.post(
      Uri.parse(baseUrl + "api/users/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(loginRequest),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
