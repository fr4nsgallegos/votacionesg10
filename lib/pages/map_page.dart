import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map Page"),
      ),
      body: GoogleMap(
        onTap: (LatLng position) {
          print("lat: ${position.latitude} - lang:${position.longitude}");
          _markers.add(
            Marker(
              markerId: MarkerId(_markers.length.toString()),
              position: position,
            ),
          );
          setState(() {});
        },
        initialCameraPosition: CameraPosition(
          zoom: 15,
          target: LatLng(
            -18.00373470739627,
            -70.2326096081443,
          ),
        ),
        markers: _markers,
      ),
    );
  }
}
