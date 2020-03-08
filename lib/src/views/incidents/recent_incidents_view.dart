import 'package:bogo_ambiental_app_movil/src/models/incident_model.dart';
import 'package:bogo_ambiental_app_movil/src/services/incident_service.dart';
import 'package:flutter/material.dart';

class RecentIncidentsView extends StatefulWidget {
  @override
  _RecentIncidentsViewState createState() => _RecentIncidentsViewState();
}

class _RecentIncidentsViewState extends State<RecentIncidentsView> {

  int _page = 1;
  List<Widget> cards = new List();
  ScrollController _scrollController = new ScrollController();
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    var data = await _getIncidents();
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

  Future _getIncidents() async {
    final response = await IncidentService().getIincidents(_page);
    if (response['status']) {
      return response['data'];
    }
  }

  Widget _createIncidentsCard(IncidentModel incident) {
    return ClipRRect(
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
                maxLines: 2,
                overflow: TextOverflow.ellipsis
              ),
            ),
            _createBottomStatus()
          ],
        ),
      ),
    );
  }

  Padding _createBottomStatus() {
    return Padding(
      padding: EdgeInsets.all(7.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.check_circle, size: 18.0, color: Colors.green),
            label: Text('Estado'),
            onPressed: () {},
          ),
          FlatButton.icon(
            icon: Icon(Icons.comment, size: 18.0, color: Colors.brown),
            label: Text('Comentarios'),
            onPressed: () {},
          ),
          FlatButton.icon(
            icon: Icon(Icons.today, size: 18.0, color: Colors.blueAccent),
            label: Text('Fecha'),
            onPressed: () {},
          )
        ],
      )
    );
  }
}