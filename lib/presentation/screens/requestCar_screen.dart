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
      CameraUpdate.newLatLngZoom(LatLng(car.latitude, car.longitude), 16),
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
              initialChildSize: 0.6,
              minChildSize: 0.3,
              maxChildSize: 0.8,
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
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: nearbyCars.length,
                          itemBuilder: (context, index) {
                            Car car = nearbyCars[index];
                            return GestureDetector(
                              onTap: () {
                                _zoomToCar(car);
                              },
                              child: CarCard(
                                carName: '${car.brand} ${car.model} - ${car.year}',
                                plate: car.plate,
                                distance: '${car.latitude}, ${car.longitude}',
                                price: '15 RS/Minuto',
                                imagePath: 'lib/assets/img/golf_tsi.png',
                              ),
                            );
                          },
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

// Componente para exibir as informações do carro
class CarCard extends StatelessWidget {
  final String carName;
  final String plate;
  final String distance;
  final String price;
  final String imagePath;

  CarCard({
    required this.carName,
    required this.plate,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
