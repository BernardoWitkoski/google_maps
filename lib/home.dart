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

  _carregarMarcadores() {
    Set<Marker> marcadoresLocal = {};
    Marker campusDois = Marker(
                              infoWindow: InfoWindow(title: "Campus 2 URI Erechim"),
                              markerId: MarkerId("marker-campusDois"),
                              position: LatLng(-27.613228150440175, -52.22949919251079)
    );
    Marker casa = Marker(
                        infoWindow: InfoWindow(title: "Casa"),
                        markerId: MarkerId("marker-casa"),
                        position: LatLng(-27.634217791589663, -52.253803681189815)
    );

    marcadoresLocal.add(campusDois);
    marcadoresLocal.add(casa);
    setState(() {
      _marcadores = marcadoresLocal;
    });
  }

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _marcadores = {};

@override
  void initState() {
    super.initState();
    _carregarMarcadores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          zoom: 16,
          target: LatLng(-27.61310389786854, -52.22349063811818)),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: _marcadores,
        ),

    );
  }
}