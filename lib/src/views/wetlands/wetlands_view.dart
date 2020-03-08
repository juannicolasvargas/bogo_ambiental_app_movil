import 'package:bogo_ambiental_app_movil/src/services/westland_service.dart';
import 'package:flutter/material.dart';
import 'package:bogo_ambiental_app_movil/src/widgets/card_swiper_widget.dart';

class WetlandsView extends StatefulWidget {
  @override
  _WetlandsViewState createState() => _WetlandsViewState();
}

class _WetlandsViewState extends State<WetlandsView> {
  
  final wetlandsService = new WestlandService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de Humedales'),
      ),
      body: _createWetlandsSwiper()
    );
  }

  Widget _createWetlandsSwiper() {
    return FutureBuilder(
      future: _getWetlands(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
         return CardSwiperWidget(
          wetlands: snapshot.data,
        ); 
        } else {
          return Center(child: CircularProgressIndicator());
        }
      
      },
    );
  }

  Future _getWetlands() async {
    final response = await WestlandService().dataWetlands();
    if (response['status']) {
      return response['data'];
    }
  }
}