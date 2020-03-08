import 'package:flutter/material.dart';

import 'package:bogo_ambiental_app_movil/src/views/incidents/my_incidents_view.dart';
import 'package:bogo_ambiental_app_movil/src/views/incidents/recent_incidents_view.dart';
import 'package:bogo_ambiental_app_movil/src/widgets/sign_out_button_widget.dart';

class IncidentsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _createTapController();
  }

  DefaultTabController _createTapController() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
      appBar: AppBar(
        bottom: TabBar(
              tabs: [
                Tab(text: 'Relevantes'),
                Tab(text: 'Mis reportes'),
              ],
            ),
        actions: <Widget>[
          SignOutButtonWidget()
        ],
        title: Text('Incidencias'),
      ),
        body: TabBarView(
          children: [
              RecentIncidentsView(),
              MyIncidentsView()
          ],
        ),
      ),
    );
  }
}