import 'dart:convert';
import 'dart:io';
import 'package:bogo_ambiental_app_movil/src/models/incident_model.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

import 'package:bogo_ambiental_app_movil/src/utils/sessions.dart';

class IncidentService {
  final _url = 'https://bogo-ambiental-api.herokuapp.com/api/v1';

  Future createIncident(String title, String description, File image) async {
    try {
    final url = Uri.parse("$_url/incidents");
    final minType = mime(image.path).split('/');

    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath(
      'image', image.path,
      contentType: MediaType(minType[0], minType[1])
    );

    // for example 
    imageUploadRequest.fields['title'] = title;
    imageUploadRequest.fields['description'] = description;

    imageUploadRequest.headers.addAll(Sessions().getHeader());
    imageUploadRequest.files.add(file);
    
    final streamResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamResponse);
    if (response.statusCode == 201) {
      return { 'status': true };
    }else {
      final jsonError = json.decode(response.body);
      return { 'status': false, 'error': jsonError['errors'][0] };
    }
    } catch (e) {
      return { 'status': false, 'error': 'Ha ocurrido un error inesperado.' };
    }
  }

  Future updateIncident(int id, String title, String description, File image) async {
    try {
      final url = Uri.parse("$_url/incidents/$id");

      final imageUploadRequest = http.MultipartRequest('PUT', url);
      if (image != null) {
        final minType = mime(image.path).split('/');

        final file = await http.MultipartFile.fromPath(
          'image', image.path,
          contentType: MediaType(minType[0], minType[1])
        );
        imageUploadRequest.files.add(file);
      }      

      imageUploadRequest.fields['title'] = title;
      imageUploadRequest.fields['description'] = description;

      imageUploadRequest.headers.addAll(Sessions().getHeader());   
      
      final streamResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamResponse);
      if (response.statusCode == 200) {
        return { 'status': true };
      }else {
        final jsonError = json.decode(response.body);
        return { 'status': false, 'error': jsonError['errors'][0] };
      }
    } catch (e) {
      return { 'status': false, 'error': 'Ha ocurrido un error inesperado.' };
    }
  }

  // index
  Future getIincidents(int page) async {
    var client = new http.Client();
    try {
       var url = "$_url/incidents?page=$page";
       final response = await client.get(url, headers: Sessions().getHeader());
       if (response.statusCode == 200) {
         final jsonResponse = json.decode(response.body);
         return { 'status': true, 'data': _convertIncidentsModel(jsonResponse) };    
       }else {
         return { 'status': false, 'data': null };
       }
     } catch (e) {
     } finally {
       client.close();
     }
  }

  // show
  Future getIncident(int id) async {
    var client = new http.Client();
    try {
       var url = "$_url/incidents/$id";
       final response = await client.get(url, headers: Sessions().getHeader());
       if (response.statusCode == 200) {
         final jsonResponse = json.decode(response.body);
         return { 'status': true, 'data': IncidentModel.fromJson(jsonResponse) };    
       }else {
         return { 'status': false, 'data': null };
       }
     } catch (e) {
     } finally {
       client.close();
     }
  }

  //DELETE
  Future destroy(int id) async {
    var client = new http.Client();
    try {
      var url = "$_url/incidents/$id";
      final response = await client.delete(url, headers: Sessions().getHeader());
      if (response.statusCode == 204) {        
        return { 'status': true };
      } else {
        return { 'status': false, 'error': 'Desconocido' };
      }
    } catch (e) {
    } finally {
      client.close();
    }
  }

  Future getMyIincidents(int page) async {
    var client = new http.Client();
    try {
       var url = "$_url/my_incidents?page=$page";
       final response = await client.get(url, headers: Sessions().getHeader());
       if (response.statusCode == 200) {
         final jsonResponse = json.decode(response.body);
         return { 'status': true, 'data': _convertIncidentsModel(jsonResponse) };    
       }else {
         return { 'status': false, 'data': null };
       }
     } catch (e) {
     } finally {
       client.close();
     }
  }

  List _convertIncidentsModel(incidents) {
    final incidentsMap = new List();
    for (var incident in incidents) {
      incidentsMap.add(IncidentModel.fromJson(incident));
    }
    return incidentsMap;
  }

}