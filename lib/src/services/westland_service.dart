import 'dart:convert';

import 'package:bogo_ambiental_app_movil/src/models/wetland_model.dart';
import 'package:http/http.dart' as http;
import 'package:bogo_ambiental_app_movil/src/utils/sessions.dart';

class WestlandService {
  final _url = 'https://bogo-ambiental-api.herokuapp.com/api/v1';

  //Wetlands index
  Future dataWetlands() async {
     var client = new http.Client();
     try {
       var url = "$_url/wetlands";
       final response = await client.get(url, headers: Sessions().getHeader());
       if (response.statusCode == 200) {
         final jsonResponse = json.decode(response.body);
         return { 'status': true, 'data': _convertWestlandsModel(jsonResponse) };    
       }else {
         return { 'status': false, 'data': null };
       }
     } catch (e) {
     } finally {
       client.close();
     }
  }

  //Wetlands GET
  Future dataWetlandsDetail(int _wetlandId) async {
     var client = new http.Client();
     try {
       var url = "$_url/wetlands/$_wetlandId";
       final response = await client.get(url, headers: Sessions().getHeader());
       if (response.statusCode == 200) {
         final jsonResponse = json.decode(response.body);
         final wetlandModel = WetlandModel.fromJson(jsonResponse);
         return { 'status': true, 'data': wetlandModel };    
       }else {
         return { 'status': false, 'data': null };
       }
     } catch (e) {
     } finally {
       client.close();
     }
  }

  List _convertWestlandsModel(wetlands) {
    final wetlandsMap = new List();
    for (var wetland in wetlands) {
      wetlandsMap.add(WetlandModel.fromJson(wetland));
    }
    return wetlandsMap;
  }
}