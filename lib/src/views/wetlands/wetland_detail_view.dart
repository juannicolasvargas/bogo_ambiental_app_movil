import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:bogo_ambiental_app_movil/src/models/wetland_model.dart';
import 'package:bogo_ambiental_app_movil/src/services/westland_service.dart';

class WetlandsDetailView extends StatelessWidget {

  final String _urlMore = 'http://humedalesbogota.com/humedales-bogota/';

  @override
  Widget build(BuildContext context) {
    final WetlandModel wetland = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: _detailWetlandBuilder(wetland),
    );
  }

  Widget _containerDetail(WetlandModel wetland) {
    return CustomScrollView(
      slivers: <Widget>[
        _sliverAppbar(wetland),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SizedBox(height: 10.0),
              _descriptionTitle(),
              SizedBox(height: 10.0),
              _textDescription(wetland),
              _dataSheet(wetland),
              SizedBox(height: 10.0),
              _linkMoreInformation(),
              SizedBox(height: 40.0),
            ]
          ),
        )
      ],
    );
  }

  Widget _linkMoreInformation() {
    return Center(
      child: InkWell(
        child: Text("Más información",
        style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 25.0),
        ),
        onTap: () async {
          if (await canLaunch(_urlMore)) {
            await launch(_urlMore);
          }
        },
      ),
    );
  }

  Widget _descriptionTitle() {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Center(
        child: Text(
          'Descripción',
          style: TextStyle(color: Colors.black, fontSize: 30),
          )
        ),
    );
  }

  Widget _textDescription(wetland) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(wetland.description,
      textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _dataSheet(WetlandModel wetland) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('Ficha técnica',
              style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Row(
            children: <Widget>[
              Text('- Localidad: ${wetland.location}',
              textAlign: TextAlign.left),
            ],
          ),
          Row(
            children: <Widget>[
              Text('- Extensión: ${wetland.extensionW}',
              textAlign: TextAlign.left),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sliverAppbar(WetlandModel wetland) {
    return SliverAppBar(
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 2.0,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.symmetric(horizontal: 80.0),
        centerTitle: true,
        title: Text(
          wetland.name,
          style: TextStyle(color: Colors.white),
          ),
        background: FadeInImage(
          placeholder: AssetImage('assets/image-loading.gif'),
          image: NetworkImage(wetland.image),
          fit: BoxFit.cover,
        ),
      )
    );
  }

  Widget _detailWetlandBuilder(WetlandModel wetland) {
    return FutureBuilder(
      future: _getWetlandDetail(wetland.id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
         return _containerDetail(wetland);
        } else {
          return Center(child: CircularProgressIndicator());
        }  
      },
    );
  }

  Future _getWetlandDetail(int wetlandId) async {
    final response = await WestlandService().dataWetlandsDetail(wetlandId);
    if (response['status']) {
      return response['data'];
    }
  }
}