import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:urbandrive_dart/data/models/user.dart';
import '../../config/api_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ApiService apiService = ApiService(); // Instância do serviço de API
  bool _isLoading = false; // Controla o estado de carregamento

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    // Cria o mapa com os dados de login
    Map<String, String> loginRequest = {
      "email": _emailController.text,
      "password": _passwordController.text,
    };

    // Chama a função de login
    User? loginUser = await apiService.loginUser(loginRequest);

    setState(() {
      _isLoading = false;
    });

    if (loginUser != null) {
      // Se o login for bem-sucedido, mostre uma mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login realizado com sucesso!')),
      );
      // Navegar para a tela inicial ou outra página
      Navigator.of(context).pushNamed('/home'); // Ajuste a rota conforme necessário
    } else {
      // Se houver um erro, mostre uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao realizar login. Verifique suas credenciais.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'lib/assets/img/background_image.png', // Caminho da imagem que você usará
              height: MediaQuery.of(context).size.height * 0.4, // Define um tamanho relativo
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  // Campo de E-mail
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'E-mail',
                      filled: true,
                      fillColor: Colors.pinkAccent.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  // Campo de Senha
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Senha',
                      filled: true,
                      fillColor: Colors.pinkAccent.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  // Botão de Login
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _login, // Desativa o botão se estiver carregando
                    icon: _isLoading
                        ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : SvgPicture.asset(
                      'lib/assets/icons/arrow.svg',
                      height: 20, // Ajuste o tamanho do ícone conforme necessário
                    ),
                    label: _isLoading ? Text("") : Text("Login"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
