import 'dart:convert';
import 'package:bogo_ambiental_app_movil/src/shared_preferences/user_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:bogo_ambiental_app_movil/src/models/user_model.dart';

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