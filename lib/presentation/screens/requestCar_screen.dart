import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Mapscreen.dart';
import '../../data/models/car.dart';
import '../../config/api_service.dart';

class RequestAndNearbyCarsScreen extends StatefulWidget {
  @override
  _RequestAndNearbyCarsScreenState createState() =>
      _RequestAndNearbyCarsScreenState();
}

class _RequestAndNearbyCarsScreenState
    extends State<RequestAndNearbyCarsScreen> {
  bool showNearbyCars = false;
  List<Car> nearbyCars = [];
  GoogleMapController? mapController;
  final LatLng _initialLocation = LatLng(-23.55052, -46.633308);
  Set<Marker> carMarkers = Set();
  int? selectedCarIndex;

  void toggleNearbyCars() async {
    ApiService apiService = ApiService();
    List<Car> cars = await apiService.getNearbyCars();

    setState(() {
      nearbyCars = cars;
      showNearbyCars = true;
      _addCarMarkers();
    });
  }

  void _addCarMarkers() {
    Set<Marker> markers = nearbyCars.map((car) {
      return Marker(
        markerId: MarkerId(car.id.toString()),
        position: LatLng(car.latitude, car.longitude),
        infoWindow: InfoWindow(title: '${car.brand} ${car.model}'),
      );
    }).toSet();

    setState(() {
      carMarkers = markers;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _zoomToCar(Car car) {
    mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(car.latitude, car.longitude), 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Aqui você usa o MapScreen modularizado
          MapScreen(
            initialLocation: _initialLocation,
            carMarkers: carMarkers,
            onMapCreated: _onMapCreated,
          ),
          if (!showNearbyCars)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: toggleNearbyCars,
                  child: Text('Solicite um carro'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
              ),
            ),
          if (showNearbyCars)
            DraggableScrollableSheet(
              initialChildSize: 0.4, // Ajuste conforme necessário
              minChildSize: 0.4,     // Ajuste conforme necessário
              maxChildSize: 0.4,     // Ajuste conforme necessário
              builder: (BuildContext context, ScrollController scrollController) {
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
                            color: Colors.black,
                          ),
                        ),
                      ),
                      // Mantendo o tamanho fixo para o card e garantindo o tamanho da imagem
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: nearbyCars.length,
                          itemBuilder: (context, index) {
                            Car car = nearbyCars[index];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCarIndex = index; // Marca o carro como selecionado
                                });
                                _zoomToCar(car); // Zoom no carro quando clicado
                              },
                              child: CarCard(
                                carName: '${car.brand} ${car.model} - ${car.year}',
                                plate: car.plate,
                                distance: '${car.latitude}, ${car.longitude}',
                                price: '15 R\$ /hora',
                                imagePath: 'lib/assets/img/golf_tsi.png',
                                isSelected: selectedCarIndex == index, // Verifica se o carro está selecionado
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
        ],
      ),
    );
  }
}

// Componente para exibir as informações do carro
class CarCard extends StatelessWidget {
  final String carName;
  final String plate;
  final String distance;
  final String price;
  final String imagePath;
  final bool isSelected;

  CarCard({
    required this.carName,
    required this.plate,
    required this.distance,
    required this.price,
    required this.imagePath,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    // Definindo tamanho fixo para o card e a imagem
    final double cardWidth = 200; // Tamanho fixo para o card
    final double cardHeight = 200; // Altura fixa para o card

    return SizedBox(
      width: cardWidth, // Tamanho fixo da largura do card
      height: cardHeight, // Altura fixa do card
      child: Card(
        color: isSelected ? Colors.pink[300] : Colors.black12, // Cor do card quando selecionado
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: cardWidth,
                height: cardHeight * 0.5, // Garantindo que a imagem tenha metade do tamanho do card
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    carName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Placa: $plate',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Localização: $distance',
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
      ),
    );
  }
}
