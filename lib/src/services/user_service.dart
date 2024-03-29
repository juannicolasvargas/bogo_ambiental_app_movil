import 'dart:convert';
import 'dart:io';
import 'package:bogo_ambiental_app_movil/src/shared_preferences/user_preferences.dart';
import 'package:bogo_ambiental_app_movil/src/utils/sessions.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:bogo_ambiental_app_movil/src/models/user_model.dart';
import 'package:mime_type/mime_type.dart';

class UserService {
  final _prefs = new UserPreferences();
  final _url = 'https://bogo-ambiental-api.herokuapp.com/api/v1';

  // Futures de peticiones al Back-end

  Future createLogin(String email, String password) async {
    var client = new http.Client();
    try {
      var data = { "email": email, "password": password };
      var url = "$_url/auth/sign_in";
      final response = await client.post(url, body: data);
      final jsonResponse = json.decode(response.body);
      if(response.statusCode == 200) {
        final newHeaders = _getHeadersAuth(response.headers);
        final newUser = UserModel.fromJson(jsonResponse);
        return { 'status': _saveDataPreferences(newHeaders, newUser), 'error': null };
      }else {
         return { 'status': false, 'error': jsonResponse['errors'][0] };
      }

    } catch (e) {
      return { 'status': false, 'error': 'Intentalo nuevamente mas tarde' };
    }finally {
      client.close();
    }
  }

  Future createRegister(String email, String name, String lastName, String password) async {
    var client = new http.Client();
    try {
      var data = { "email": email, "password": password, 'password_confirmation': password, 'name': name, 'last_name': lastName };
      var url = "$_url/auth";
      final response = await client.post(url, body: data);
      final jsonResponse = json.decode(response.body);
      if(response.statusCode == 200) {
        final newHeaders = _getHeadersAuth(response.headers);
        final newUser = UserModel.fromJson(jsonResponse);
        return { 'status': _saveDataPreferences(newHeaders, newUser), 'error': null };
      }else {
         return { 'status': false, 'error': jsonResponse['errors']['full_messages'][0] };
      }

    } catch (e) {
      return { 'status': false, 'error': 'Intentalo nuevamente mas tarde' };
    }finally {
      client.close();
    }
  }

  Future signOut() async {
    var client = new http.Client();
    try {
      var url = "$_url/auth/sign_out";
      final response = await client.delete(url, headers: Sessions().getHeader());
      var jsonResponse = json.decode(response.body);
      if (response.statusCode == 200) {        
        return { 'status': _destroyDataPreferences() };
      } else {
        return { 'status': false, 'error': jsonResponse['errors'][0] };
      }
    } catch (e) {
    } finally {
      client.close();
    }
  }

  Future uploadAvatarImage(File image) async {
    try {
    final url = Uri.parse("$_url/avatar_images");
    final minType = mime(image.path).split('/');

    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath(
      'avatar_image', image.path,
      contentType: MediaType(minType[0], minType[1])
    );
    // for example 
    // imageUploadRequest.fields['nombre'] = 'nicolasssssss';

    imageUploadRequest.headers.addAll(Sessions().getHeader());
    imageUploadRequest.files.add(file);
    
    final streamResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamResponse);
    if (response.statusCode == 200) {
      _prefs.image = response.body;
      return { 'status': true };
    }else {
      final jsonError = json.decode(response.body);
      return { 'status': false, 'error': jsonError['errors'][0] };
    }
    } catch (e) {
      return { 'status': false, 'error': 'Ha ocurrido un error inesperado.' };
    }
  }

  bool _destroyDataPreferences() {
    try {
      _prefs.token = null;
      _prefs.client = null;
      _prefs.uid = null;
      _prefs.type = null;
      _prefs.id = null;
      _prefs.name = null;
      _prefs.lastName = null;
      _prefs.image = null;
      return true;
    } catch (e) {
      return false;
    }
  }

  bool _saveDataPreferences(Map<String, String> headers, UserModel user) {
    try {
      _prefs.token = headers['access-token'];
      _prefs.client = headers['client'];
      _prefs.uid = headers['uid'];
      _prefs.type = headers['token-type'];
      _prefs.id = user.id;
      _prefs.name = user.name;
      _prefs.lastName = user.lastName;
      _prefs.image = user.image;
      return true;

    } catch (e) {
      return false;
    }
  }
  
  Map<String, String> _getHeadersAuth(headers) {
    Map<String, String> nuevosHeader = new Map();
    nuevosHeader['access-token'] = headers['access-token'];
    nuevosHeader['client'] = headers['client'];
    nuevosHeader['uid'] = headers['uid'];
    nuevosHeader['token-type'] = headers['token-type'];
    return nuevosHeader;
  }

}