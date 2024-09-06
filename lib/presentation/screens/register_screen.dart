import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
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
                height: 80), // Espaçamento para mover os campos mais para cima
            // Campos de entrada
            Text('Registre-se já',
                style: TextStyle(
                  fontSize: 24, // Tamanho da fonte
                  fontWeight: FontWeight.bold, // Deixa o texto em negrito
                  color:
                      Colors.pink, // Cor do texto, ajuste conforme necessário
                )),
            SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nome',
                fillColor: Colors.pink[100],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
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
            // Botão de registro
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              icon: SvgPicture.asset('lib/assets/icons/arrow.svg'),
              label: Text('Register'),
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
              height: 250, // Ajuste o tamanho conforme necessário
              fit: BoxFit.contain, // Ajusta a imagem
            ),
          ],
        ),
      ),
    );
  }
}
