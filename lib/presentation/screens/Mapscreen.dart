import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final LatLng initialLocation;
  final Set<Marker> carMarkers;
  final Function(GoogleMapController) onMapCreated;

  MapScreen({
    required this.initialLocation,
    required this.carMarkers,
    required this.onMapCreated,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: widget.onMapCreated,
      initialCameraPosition: CameraPosition(
        target: widget.initialLocation,
        zoom: 14.0,
      ),
      markers: widget.carMarkers,
    );
  }
}
