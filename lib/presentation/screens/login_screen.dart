import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 100), // Adiciona um espaçamento para começar mais acima
            // Campos de entrada
            Text('Faça seu login',
                style: TextStyle(
                  fontSize: 24, // Tamanho da fonte
                  fontWeight: FontWeight.bold, // Deixa o texto em negrito
                  color:
                      Colors.pink, // Cor do texto, ajuste conforme necessário
                )),
            SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
                fillColor: Colors.pink[100],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                fillColor: Colors.pink[100],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            SizedBox(height: 30), // Espaçamento antes do botão
            // Botão de login
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/requestCar_screen');
              },
              icon: SvgPicture.asset('lib/assets/icons/arrow.svg'),
              label: Text('Login'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue[300], // Cor de fundo mais clara
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                minimumSize: Size(150, 50), // Tamanho fixo do botão
              ),
            ),
            Spacer(), // Empurra a imagem para o rodapé
            // Imagem de fundo, posicionada logo abaixo do botão
            Image.asset(
              'lib/assets/img/background_image.png', // Caminho da sua imagem
              fit: BoxFit.contain, // Ajusta a imagem
            ),
          ],
        ),
      ),
    );
  }
}
