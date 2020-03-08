import 'package:flutter/material.dart';

import 'package:bogo_ambiental_app_movil/src/models/incident_model.dart';
import 'package:bogo_ambiental_app_movil/src/services/incident_service.dart';

class IncidentDetailView extends StatefulWidget {
  @override
  _IncidentDetailViewState createState() => _IncidentDetailViewState();
}

class _IncidentDetailViewState extends State<IncidentDetailView> {
  @override
  Widget build(BuildContext context) {
    final IncidentModel incident = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: _detailIncidentBuilder(incident),
    );
  }

  Widget _containerDetail(IncidentModel incident) {
    return CustomScrollView(
      slivers: <Widget>[
        _sliverAppbar(incident),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SizedBox(height: 10.0),
              _descriptionTitle(),
              SizedBox(height: 10.0),
              _textDescription(incident),
            ]
          ),
        )
      ],
    );
  }

  Widget _descriptionTitle() {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Center(
        child: Text(
          'Detalle',
          style: TextStyle(color: Colors.black, fontSize: 30),
          )
        ),
    );
  }

  Widget _textDescription(IncidentModel incident) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(incident.description,
      textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _sliverAppbar(IncidentModel incident) {
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
          incident.title,
          style: TextStyle(color: Colors.white),
          ),
        background: FadeInImage(
          placeholder: AssetImage('assets/image-loading.gif'),
          image: NetworkImage(incident.image),
          fit: BoxFit.cover,
        ),
      )
    );
  }

  Widget _detailIncidentBuilder(IncidentModel incident) {
    return FutureBuilder(
      future: _getIncidentDetail(incident.id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
         return _containerDetail(incident);
        } else {
          return Center(child: CircularProgressIndicator());
        }  
      },
    );
  }

  Future _getIncidentDetail(int incidentId) async {
    final response = await IncidentService().getIncident(incidentId);
    if (response['status']) {
      return response['data'];
    }
  }
}