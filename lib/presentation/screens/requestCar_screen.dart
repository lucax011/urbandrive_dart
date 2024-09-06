import 'package:flutter/material.dart';

class RequestAndNearbyCarsScreen extends StatefulWidget {
  @override
  _RequestAndNearbyCarsScreenState createState() =>
      _RequestAndNearbyCarsScreenState();
}

class _RequestAndNearbyCarsScreenState
    extends State<RequestAndNearbyCarsScreen> {
  bool showNearbyCars = false; // Controle de exibição da lista de carros

  void toggleNearbyCars() {
    setState(() {
      showNearbyCars =
          true; // Exibe os carros próximos quando o botão é pressionado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Adicionar um mapa ou imagem placeholder
          Center(
            child: Image.asset(
              'lib/assets/img/map_placeholder.png', // Substitua pelo Google Maps ou outra API
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          // Botão para solicitar um carro, inicialmente visível
          if (!showNearbyCars)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed:
                      toggleNearbyCars, // Ação para exibir os carros próximos
                  child: Text('Solicite um carro'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    minimumSize: Size(double.infinity, 50), // Largura total
                  ),
                ),
              ),
            ),
          // Lista de carros próximos, exibida quando o botão é pressionado
          if (showNearbyCars)
            DraggableScrollableSheet(
              initialChildSize: 0.6,
              minChildSize: 0.3,
              maxChildSize: 0.8,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  color: Colors.pink[200],
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Carros próximos a você',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          controller: scrollController,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Define o número de colunas
                            crossAxisSpacing:
                                10, // Espaçamento entre as colunas
                            mainAxisSpacing: 10, // Espaçamento entre as linhas
                            childAspectRatio: 0.75, // Proporção dos itens
                          ),
                          itemCount: 2, // Número de itens na grid
                          itemBuilder: (context, index) {
                            // Adiciona os cards dos carros
                            if (index == 0) {
                              return CarCard(
                                carName: 'Ford Ka 2020',
                                distance: '150 metros',
                                price: '15 Reais/hora',
                                imagePath: 'lib/assets/img/ford_ka.png',
                              );
                            } else {
                              return CarCard(
                                carName: 'Golf Tsi',
                                distance: '50 metros',
                                price: '25 Reais/hora',
                                imagePath: 'lib/assets/img/golf_tsi.png',
                              );
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Ação ao clicar em continuar
                          },
                          child: Text('Continue'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green,
                            minimumSize: Size(double.infinity, 50),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class CarCard extends StatelessWidget {
  final String carName;
  final String distance;
  final String price;
  final String imagePath;

  CarCard({
    required this.carName,
    required this.distance,
    required this.price,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Image.asset(imagePath, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  carName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  distance,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
