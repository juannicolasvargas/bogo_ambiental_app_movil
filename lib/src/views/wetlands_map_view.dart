import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WetlandsMapView extends StatelessWidget {
  final Completer _googleController = Completer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar'),
      ),
      body: Stack(
        children: <Widget>[
          _mapDefault(),
        ],
      ),
    );
  }

  Widget _dataWetlands() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: EdgeInsets.all(8.0),
            )
          ],
        ),
      ),
    );

  }

  Widget _mapDefault() {
    double lat = 4.60971;
    double long = -74.08175;
    return GoogleMap(
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      rotateGesturesEnabled: true,
      scrollGesturesEnabled: true,
      tiltGesturesEnabled: true,
      zoomGesturesEnabled: true,
      initialCameraPosition: CameraPosition(
        zoom: 12.0,
        target: LatLng(lat, long)
      ),
      onMapCreated: (GoogleMapController controller) {
        _googleController.complete(controller);
      },
      markers: <Marker> {
        _markerOne()
      }
    );
  }

  Marker _markerOne() {
    return Marker(
      markerId: MarkerId('prueba'),
      position: LatLng(4.608967757103997, -74.08313838134988),
      infoWindow: InfoWindow(title: 'pruebisima', snippet: 'asnjsadbajsndbasn'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed
      )
    );
  }
}