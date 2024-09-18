import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drive Urban'),
        actions: [
          PopupMenuButton<String>(
            icon: SvgPicture.asset('lib/assets/icons/burger_menu.svg',
                width: 33), // Ícone personalizado
            onSelected: (String choice) {
              // Redirecionar de acordo com a escolha do usuário
              switch (choice) {
                case 'Login':
                  Navigator.pushNamed(
                      context, '/login'); // Redireciona para a tela de login
                  break;
                case 'Registrar':
                  Navigator.pushNamed(context,
                      '/register'); // Redireciona para a tela de registro
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Login', 'Registrar'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem abaixo da AppBar
            Image.asset('lib/assets/img/introphot.png',
                fit: BoxFit.cover, width: double.infinity),

            // Título Introdução
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Reinventamos o aluguel de carros',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              ),
            ),

            // Texto Introdução com parte em negrito
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: RichText(
                text: TextSpan(
                  text: "Aqui na Drive urban, você aluga um carro por algumas\n"
                      "horas, dias ou por quanto tempo precisar!\n"
                      "E o melhor ",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                      text: "sem filas e sem papelada, tudo pelo app.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            // CardView
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                margin: EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Imagem dentro do Card ajustada para preencher a largura do Card
                    ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25),
                        ),
                        child: Image.asset(
                          'lib/assets/img/cardphot.png',
                          fit: BoxFit.cover,
                          width: double.infinity, // Ajuste para imagem preencher a largura do Card
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Título dentro do Card
                          Text(
                            'Precisa de um carro agora?',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          // Descrição dentro do Card
                          Text(
                            'Encontre o mais próximo de você e alugue na hora!',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 16),
                          // Botão dentro do Card
                          ElevatedButton.icon(
                            icon:
                                SvgPicture.asset('lib/assets/icons/arrow.svg'),
                            label: Text('Mais Informações'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.pink, // Cor do texto
                            ),
                            onPressed: () {
                              // Implementar a ação do botão
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Ação de mais informações')),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Título Final
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Alugar um carro agora é fácil!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              ),
            ),

            // Texto Final com parte em negrito
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: RichText(
                text: TextSpan(
                  text:
                      "Faça a sua reserva e abra o seu carro através do seu celular. "
                      "Encontre o estacionamento mais próximo, escolha o carro e a quantidade "
                      "de tempo que quer ficar com ele. ",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          "Agora é só chegar no local, abrir o seu carro e aproveitar a viagem!",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
