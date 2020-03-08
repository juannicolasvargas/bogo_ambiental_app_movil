import 'package:flutter/material.dart';

import 'package:bogo_ambiental_app_movil/src/views/incidents/edit_incident.dart';
import 'package:bogo_ambiental_app_movil/src/views/wetlands/wetland_detail_view.dart';
import 'package:bogo_ambiental_app_movil/src/views/wetlands/wetlands_map_view.dart';
import 'package:bogo_ambiental_app_movil/src/views/wetlands/wetlands_view.dart';
import 'package:bogo_ambiental_app_movil/src/views/incidents/incident_detail_view.dart';
import 'package:bogo_ambiental_app_movil/src/views/incidents/new_incident.dart';
import 'package:bogo_ambiental_app_movil/src/views/incidents/incidents_view.dart';
import 'package:bogo_ambiental_app_movil/src/views/login_view.dart';
import 'package:bogo_ambiental_app_movil/src/views/home_view.dart';
import 'package:bogo_ambiental_app_movil/src/views/register_view.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    'login'           : (BuildContext context) => LoginView(),
    'register'        : (BuildContext context) => RegisterView(),
    'home'            : (BuildContext context) => HomeView(),
    'wetlands_map'    : (BuildContext context) => WetlandsMapView(),
    'wetlands'        : (BuildContext context) => WetlandsView(),
    'wetlands_detail' : (BuildContext context) => WetlandsDetailView(),
    'incidents'       : (BuildContext context) => IncidentsView(),
    'new_incident'    : (BuildContext context) => NewIncident(),
    'incident_detail' : (BuildContext context) => IncidentDetailView(),
    'edit_incident'   : (BuildContext context) => EditIncident(),
  };
}