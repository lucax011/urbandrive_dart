import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/models/user.dart';
import '../data/models/car.dart';

class ApiService {
  final String baseUrl = "http://10.0.2.2:3000/";

  // Método para registrar um usuário
  Future<User?> registerUser(User user) async {
    final response = await http.post(
      Uri.parse(baseUrl + "api/users/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body)); // Retorna o usuário com ID
    } else if (response.statusCode == 409) {
      throw Exception('Email já está cadastrado');
    } else {
      return null;
    }
  }

  // Método para buscar carros próximos
  Future<List<Car>> getNearbyCars() async {
    try {
      final response = await http.get(Uri.parse(baseUrl + "api/cars"));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((car) => Car.fromJson(car)).toList();
      } else {
        // Caso o status code não seja 200, lança uma exceção com mais detalhes
        throw Exception('Erro ao buscar carros: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      // Captura a exceção e exibe mais informações para entender o erro
      print('Erro ao buscar carros: $e');
      throw Exception('Falha ao carregar os carros. Detalhes: $e');
    }
  }


  // Método para login do usuário
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
