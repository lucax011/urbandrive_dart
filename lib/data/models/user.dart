class User {
  final int? id; // O id é opcional
  final String name;
  final String email;
  final String password;

  User({
    this.id, // ID pode ser nulo na criação do usuário
    required this.name,
    required this.email,
    required this.password,
  });

  // Converte um objeto User em JSON (para enviar na requisição)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  // Cria um objeto User a partir do JSON retornado pela API
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'], // O ID será atribuído aqui após o registro
      name: json['name'],
      email: json['email'],
      password: '', // Não retorna a senha no fromJson por questões de segurança
    );
  }
}
