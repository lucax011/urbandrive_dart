import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatelessWidget {
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
            child: SingleChildScrollView( // Resolving scrolling issues
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  TextField(
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
                  TextField(
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
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    icon: SvgPicture.asset(
                      'lib/assets/icons/arrow.svg',
                      height: 20, // Ajuste o tamanho do ícone conforme necessário
                    ),
                    label: Text("Login"),
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
