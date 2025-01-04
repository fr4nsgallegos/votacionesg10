import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map2CustomMarkerPage extends StatelessWidget {
  Set<Marker> _markers = {};

  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  addMarkers() async {
    Set<Marker> auxMarkers = Set();

    LatLng pos1 = LatLng(-8.075835083452857, -79.0558760909236);
    LatLng pos2 = LatLng(-8.07509147417602, -79.05166562106169);
    LatLng pos3 = LatLng(-8.0789747519678, -79.0536456798616);

    BitmapDescriptor designBit1 = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(94, 94)), "assets/icons/orange.png");
    BitmapDescriptor designBit2 = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(94, 94)), "assets/icons/blue.png");
    BitmapDescriptor designBit3 = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(94, 94)), "assets/icons/green.png");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _customInfoWindowController.googleMapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(-8.076623758462205, -79.05342567332829),
          zoom: 17,
        ),
        markers: _markers,
      ),
    );
  }
}
