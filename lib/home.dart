import 'package:flutter/material.dart';
//google maps required imports
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          zoom: 16,
          target: LatLng(-27.61310389786854, -52.22349063811818)),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          }
        ),

    );
  }
}