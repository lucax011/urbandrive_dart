import 'package:flutter/material.dart';
import 'package:urbandrive_dart/presentation/screens/login_screen.dart';
import 'package:urbandrive_dart/presentation/screens/main_screen.dart';
import 'package:urbandrive_dart/presentation/screens/register_screen.dart';
import 'package:urbandrive_dart/presentation/screens/requestCar_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Urban Drive',
      theme: ThemeData(
        // Defina o tema da aplicação
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      initialRoute: '/', // Define a rota inicial
      routes: {
        '/': (context) => MainScreen(), // Tela inicial
        '/login': (context) => LoginScreen(), // Tela de login
        '/register': (context) => RegisterScreen(), // Tela de registro
        '/requestCar_screen': (context) =>
            RequestAndNearbyCarsScreen(), // Tela de request para carros
      },
    );
  }
}
