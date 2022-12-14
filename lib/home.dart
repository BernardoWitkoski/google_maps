import 'package:flutter/material.dart';
//google maps required imports
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geolocator/geolocator.dart';


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
  
  _carregaPolygons() {

    Set<Polygon> listaPolygons = {};
    Polygon polygonOne = Polygon(
      fillColor: Colors.blue,
      strokeWidth: 1,
      strokeColor: Colors.blue,
      polygonId: PolygonId("p1"), 
      consumeTapEvents: true,
      onTap: (() {
        print("test on tap");
      }),
      points: [
              LatLng(-27.61353960463589, -52.229360639505174),
              LatLng(-27.612651159928355, -52.22954437096256),
              LatLng(-27.613018632696317, -52.22863621263976), 
              ]);
    // Polygon polygonTwo = Polygon(polygonId: PolygonId("p2"));
  
  listaPolygons.add(polygonOne);
  setState(() {
    _polygons  = listaPolygons;
  });
  
  }

  _carregaPolylines() {
    Set<Polyline> listaPolylines = {};
    Polyline linhaOne = Polyline(
      color: Colors.red,
      polylineId: PolylineId("pl1"),
      points: 
        [
          LatLng(-27.613228150440175, -52.22949919251079),
          LatLng(-27.634217791589663, -52.253803681189815),
          LatLng(-27.61303735423298, -52.223293725688706),
          LatLng(-27.60197643731682, -52.235902168142516),
        ]    
    );
    listaPolylines.add(linhaOne);
    setState(() {
      _polylines = listaPolylines;
    });
  }

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _marcadores = {};
  Set<Polygon> _polygons = {};
  Set<Polyline> _polylines = {};

  CameraPosition _cameraPosition = CameraPosition(
          zoom: 16,
          target: LatLng(-27.61310389786854, -52.22349063811818),
      );

  _recuperaLocalizacaoUsuario() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _cameraPosition = CameraPosition(target: LatLng(position.latitude, position.longitude));
    });
  }



@override
  void initState() {
    super.initState();
    _carregarMarcadores();
    _carregaPolygons();
    _carregaPolylines();
    _recuperaLocalizacaoUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(onPressed: _recuperaLocalizacaoUsuario),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _cameraPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          polygons: _polygons,
          polylines: _polylines,
          markers: _marcadores,
        ),
    );
  }
}