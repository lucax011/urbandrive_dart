class Car {
  final String id;
  final String model;
  final String plate;
  final String brand;
  final int year;
  final double latitude;
  final double longitude;

  Car({
    required this.id,
    required this.model,
    required this.plate,
    required this.brand,
    required this.year,
    required this.latitude,
    required this.longitude,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'].toString(),
      model: json['model'],
      plate: json['plate'],
      brand: json['brand'],
      year: json['year'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
