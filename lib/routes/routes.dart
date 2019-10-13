import 'package:flutter/material.dart';

import 'package:bogo_ambiental_app_movil/views/login_view.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    'login'   : (BuildContext context) => LoginView()
  };
}