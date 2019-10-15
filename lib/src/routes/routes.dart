import 'package:flutter/material.dart';

import 'package:bogo_ambiental_app_movil/src/views/login_view.dart';
import 'package:bogo_ambiental_app_movil/src/views/home_view.dart';
import 'package:bogo_ambiental_app_movil/src/views/register_view.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    'login'   : (BuildContext context) => LoginView(),
    'register'    : (BuildContext context) => RegisterView(),
    'home'    : (BuildContext context) => HomeView()
  };
}