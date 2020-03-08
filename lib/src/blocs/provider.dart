import 'package:flutter/material.dart';

import 'package:bogo_ambiental_app_movil/src/blocs/login_bloc.dart';
export 'package:bogo_ambiental_app_movil/src/blocs/login_bloc.dart';
import 'package:bogo_ambiental_app_movil/src/blocs/incident_bloc.dart';
export 'package:bogo_ambiental_app_movil/src/blocs/incident_bloc.dart';

class Provider extends InheritedWidget {
  final loginBloc = LoginBloc();
  final _incidentBloc = IncidentBloc();

  Provider({Key key, Widget child})
    : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of (BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).loginBloc;
  }

  static IncidentBloc incidentBloc (BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._incidentBloc;
  }
}