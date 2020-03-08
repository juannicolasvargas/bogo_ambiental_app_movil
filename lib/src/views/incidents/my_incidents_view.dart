import 'package:flutter/material.dart';

import 'package:bogo_ambiental_app_movil/src/models/incident_model.dart';
import 'package:bogo_ambiental_app_movil/src/services/incident_service.dart';

class MyIncidentsView extends StatefulWidget {
  @override
  _MyIncidentsViewState createState() => _MyIncidentsViewState();
}

class _MyIncidentsViewState extends State<MyIncidentsView> {

  int _page = 1;
  List<Widget> cards = new List();
  ScrollController _scrollController = new ScrollController();
  bool _isLoading = true;
  String _textDialog = 'Seguro que desea Eliminar la incidentica?';
  BuildContext _scaffoldContext;

  @override
  Widget build(BuildContext context) {
    _scaffoldContext = context;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(90, 180, 178, 1.0),
        onPressed: () => Navigator.pushNamed(context, 'new_incident'),
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20.0),
        child: Stack(
          children: <Widget>[
            ListView.builder(
              controller: _scrollController,
              itemCount: cards.length,
              itemBuilder: (BuildContext ctxt, index) {
                return  cards[index];
              }
            ),
            _loadingData()
          ],
        )
      ),
    );
  }

  @override
  void initState() { 
    super.initState();
    _buildData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _page++;
        _buildData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();

  }

  void _buildData() async {
    _isLoading = true;
    setState(() {});
    var data = await _getMyIncidents();
    _isLoading = false;
    if (!data.isEmpty) {
      for (var item in data) {
        cards.add(_createIncidentsCard(item));
      }
      if (_page != 1) {
        _scrollController.animateTo(
          _scrollController.position.pixels + 80,
          curve: Curves.fastOutSlowIn,
          duration: Duration(milliseconds: 250)
        );  
      }
    }
    setState(() {});
  }

  Widget _loadingData() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Container();
    }
  }

  Future _getMyIncidents() async {
    final response = await IncidentService().getMyIincidents(_page);
    if (response['status']) {
      return response['data'];
    }
  }

  Future _destroyIncident(IncidentModel incident) async {
    final response = await IncidentService().destroy(incident.id);
    if (response['status']) {
      return true;
    }
  }

  Widget _createIncidentsCard(IncidentModel incident) {
    return ClipRRect(
      key: Key('${incident.id}'),
      borderRadius: BorderRadius.circular(18.0),
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              onTap: () => Navigator.pushNamed(context, 'incident_detail', arguments: incident),
              contentPadding: EdgeInsets.all(10.0),
              leading: FadeInImage(
                  image: NetworkImage(incident.image),
                  placeholder: AssetImage('assets/placeholder-image.jpg'),
                  fit: BoxFit.cover,
                ),
                title: Text(
                  incident.title,
                  textAlign: TextAlign.center,
                ),
                subtitle: Text(
                incident.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 2
              ),
            ),
            _createBottomStatus(incident)
          ],
        ),
      ),
    );
  }

  Padding _createBottomStatus(IncidentModel incident) {
    return Padding(
      padding: EdgeInsets.all(0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.edit, size: 18.0, color: Colors.blue,),
            label: Text('Editar'),
            onPressed: () => Navigator.pushNamed(context, 'edit_incident', arguments: incident),
          ),
          FlatButton.icon(
            icon: Icon(Icons.delete, size: 18.0, color: Colors.pink),
            label: Text('Eliminar'),
            onPressed: () => _destroyConfirmModal(context, incident),
          )
        ],
      )
    );
  }

  void _destroyConfirmModal(BuildContext context, IncidentModel incident) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text(_textDialog),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar', style: TextStyle(color: Colors.black54),),
              onPressed: ()=> Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text('Aceptar'),
              onPressed: () async {
                final response = await _destroyIncident(incident);
                Navigator.of(context).pop();
                if (response) {
                  final snack = SnackBar(
                    backgroundColor: Color.fromRGBO(90, 180, 178, 1.0),
                    content: Text('Eliminado',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17.0)
                    ),
                    duration: Duration(seconds: 1),
                  );
                  Scaffold.of(_scaffoldContext).showSnackBar(snack);
                  cards.removeWhere((item) => item.key == Key('${incident.id}'));
                  setState(() {});
                }
              },
            )
          ],
        );
      }
    );
  }
}