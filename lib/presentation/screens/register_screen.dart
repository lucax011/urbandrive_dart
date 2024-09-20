import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/api_service.dart';
import '../../data/models/user.dart';
// Import do modelo de usuário

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ApiService apiService = ApiService(); // Instância do serviço de API
  bool _isLoading = false; // Controla o estado de carregamento

  Future<void> _register() async {
    // Valida se os campos estão preenchidos
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      // Fecha o teclado e desfoca os campos de texto antes de mostrar o SnackBar
      FocusScope.of(context).unfocus();

      await Future.delayed(Duration(milliseconds: 300)); // Aguarda brevemente o teclado fechar

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return; // Saímos da função caso algum campo esteja vazio
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Cria o objeto de usuário
      User newUser = User(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Chama a função de registro
      User? registeredUser = await apiService.registerUser(newUser);

      setState(() {
        _isLoading = false;
      });

      if (registeredUser != null) {
        // Fecha o teclado antes de exibir o SnackBar
        FocusScope.of(context).unfocus();

        await Future.delayed(Duration(milliseconds: 300)); // Aguarda o teclado fechar

        // Se o registro for bem-sucedido, mostre uma mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuário registrado com sucesso!')),
        );
        // Navegar para a tela de login ou página inicial
        Navigator.of(context).pushNamed('/login'); // Ajuste a rota conforme necessário
      }
    } catch (e) {

      // Fecha o teclado antes de exibir o SnackBar
      FocusScope.of(context).unfocus();

      await Future.delayed(Duration(milliseconds: 300)); // Aguarda o teclado fechar

      // Verifica se o erro é relacionado a usuário já cadastrado
      if (e.toString().contains('Email ja esta cadastrado')) {
        // Exibe a mensagem personalizada no SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usuário já cadastrado. Faça login.')),
        );
      } else {
        // Exibe a mensagem de erro genérica no SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagem de fundo alinhada na parte inferior
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
              'lib/assets/img/background_image.png',
              height: MediaQuery.of(context).size.height * 0.4,
              fit: BoxFit.cover,
            ),
          ),
          // Conteúdo principal com campos de entrada e botão de registro
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  // Campo de Nome
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Nome',
                      filled: true,
                      fillColor: Colors.pinkAccent.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
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
                  SizedBox(height: 20),
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
                  // Botão de Registro
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _register, // Desativa o botão se estiver carregando
                    icon: _isLoading
                        ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : SvgPicture.asset(
                      'lib/assets/icons/arrow.svg',
                      height: 20,
                    ),
                    label: _isLoading ? Text("") : Text("Registrar"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Botão login
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text(
                      'Já tem uma conta? Faça login!',
                      style: TextStyle(color: Colors.blueAccent),
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