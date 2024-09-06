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

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
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
