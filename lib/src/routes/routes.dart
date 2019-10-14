import 'package:flutter/material.dart';

import 'package:bogo_ambiental_app_movil/src/views/login_view.dart';
import 'package:bogo_ambiental_app_movil/src/views/home_view.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    'login'   : (BuildContext context) => LoginView(),
    'home'    : (BuildContext context) => HomeView()
  };
}