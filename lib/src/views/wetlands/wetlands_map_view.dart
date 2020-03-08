import 'dart:async';

import 'package:bogo_ambiental_app_movil/src/services/westland_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WetlandsMapView extends StatefulWidget {
  @override
  _WetlandsMapViewState createState() => _WetlandsMapViewState();
}

class _WetlandsMapViewState extends State<WetlandsMapView> {
  final Completer _googleController = Completer();
  final Set<Marker> _markers = {};
  double zoomNumber = 12.0;
  double lat = 4.60971;
  double long = -74.08175;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar'),
      ),
      body: Stack(
        children: <Widget>[
          _westlandsBuilder()
        ],
      ),
    );
  }

  Widget _westlandsBuilder() {
    return FutureBuilder(
      future: _getWetlands(),
      initialData: [],
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        return _westlandGoogleMap();
      },
    );
  }

  Widget _westlandGoogleMap() {
    return GoogleMap(
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      rotateGesturesEnabled: true,
      scrollGesturesEnabled: true,
      tiltGesturesEnabled: true,
      zoomGesturesEnabled: true,
      initialCameraPosition: CameraPosition(
        zoom: zoomNumber,
        target: LatLng(lat, long)
      ),
      onMapCreated: (GoogleMapController controller) {
        _googleController.complete(controller);
      },
      markers: _markers
    );
  }

  Future _getWetlands() async {
    final response = await WestlandService().dataWetlands();
    if (response['status']) {
      for (var item in response['data']) {
        _markers.add(
          Marker(
            markerId: MarkerId(item.name),
            position: LatLng(item.latitude, item.longitude),
            infoWindow: InfoWindow(title: item.name),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed
            )
          )
        );
      }
    }
  }
}