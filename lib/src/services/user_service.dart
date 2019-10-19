import 'dart:convert';
import 'dart:io';
import 'package:bogo_ambiental_app_movil/src/shared_preferences/user_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:bogo_ambiental_app_movil/src/models/user_model.dart';
import 'package:mime_type/mime_type.dart';

class UserService {
  final _prefs = new UserPreferences();

  Future createLogin(String email, String password) async {
    var client = new http.Client();
    try {
      var data = { "email": email, "password": password };
      var url = 'https://bogo-ambiental-api.herokuapp.com/api/v1/auth/sign_in';
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
      var url = 'https://bogo-ambiental-api.herokuapp.com/api/v1/auth';
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
      var url = 'https://bogo-ambiental-api.herokuapp.com/api/v1/auth/sign_out';
      final response = await client.delete(url, headers: _getHeader());
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
      final url = Uri.parse('https://bogo-ambiental-api.herokuapp.com/api/v1/avatar_images');
    final minType = mime(image.path).split('/');

    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath(
      'avatar_image', image.path,
      contentType: MediaType(minType[0], minType[1])
    );

    imageUploadRequest.headers.addAll(_getHeader());
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

  Map<String, String> _getHeader() {
    Map<String, String> headers = new Map();
    headers['access-token'] = _prefs.token;
    headers['client'] = _prefs.client;
    headers['uid'] = _prefs.uid;
    headers['token-type'] = _prefs.type;
    return headers;
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