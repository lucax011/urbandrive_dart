import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/api_service.dart';
import '../../data/models/user.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
                'assets/icons/burguer_menu.svg'), // Aplicando o ícone de menu
            onPressed: () {
              // Implementar ação de menu aqui
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(25), // Arredondando as bordas
              ),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(25), // Arredondando as bordas
              ),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: SvgPicture.asset(
                  'assets/icons/arrow.svg'), // Ícone de seta para frente
              label: Text('Login'),
              onPressed: () async {
                String email = emailController.text;
                String password = passwordController.text;

                User? user = await apiService.loginUser({
                  'email': email,
                  'password': password,
                });

                if (user != null) {
                  Navigator.pushNamed(context, '/main');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Login failed')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
